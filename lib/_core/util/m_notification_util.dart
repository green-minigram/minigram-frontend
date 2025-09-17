import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/_core/util/my_http.dart'; // dio, baseUrl
import 'package:minigram/data/gvm/session_gvm.dart'; // sessionProvider
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/profile/profile_page.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_page.dart';
import 'package:permission_handler/permission_handler.dart';

/// 단일 진입점: 알림 초기화 + SSE 연결 + 탭 핸들링 + 세션 변화 감지까지
class NotificationCenter with WidgetsBindingObserver {
  NotificationCenter._();
  static final NotificationCenter instance = NotificationCenter._();

  final _log = Logger();
  final _flnp = FlutterLocalNotificationsPlugin();

  GlobalKey<NavigatorState>? _navKey;
  StreamSubscription? _sseSub;
  int _retry = 0;
  String? _baseUrl;
  String? _token;
  bool _inited = false;

  // Android 알림 채널
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'minigram_notifications',
    'Minigram Notifications',
    description: 'Likes/Comments/Follow notifications',
    importance: Importance.high,
  );

  /// 여러 번 호출돼도 1회만 초기화
  Future<void> ensureInitialized(GlobalKey<NavigatorState> navKey) async {
    if (_inited) return;
    await _init(navKey);
    _inited = true;
  }

  /// 내부 초기화 (1회)
  Future<void> _init(GlobalKey<NavigatorState> navKey) async {
    _navKey = navKey;

    // 로컬 알림 초기화
    const androidInit = AndroidInitializationSettings('ic_stat_notification');
    const initSettings = InitializationSettings(android: androidInit);

    await _flnp.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (resp) {
        final payload = resp.payload;
        if (payload == null || payload.isEmpty) return;
        try {
          final map = jsonDecode(payload) as Map<String, dynamic>;
          _handleNotificationTap(map);
        } catch (e, st) {
          _log.w('payload parse 실패', e, st);
        }
      },
    );

    // Android 13+ 권한
    final status = await Permission.notification.status;
    if (status.isDenied || status.isRestricted) {
      await Permission.notification.request();
    }

    // 채널 생성
    await _flnp
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // 라이프사이클 옵저버
    WidgetsBinding.instance.addObserver(this);
  }

  /// 세션/환경 변경 시 호출
  void updateAuth({required String baseUrl, required String? token}) {
    _baseUrl = baseUrl;
    _token = (token != null && token.isNotEmpty) ? token : null;

    _log.i('updateAuth: baseUrl=$_baseUrl, hasToken=${_token != null}');
    if (_token == null) {
      _disconnect();
    } else {
      _connect();
    }
  }

  /// 앱 라이프사이클 대응
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_token == null) return;

    if (state == AppLifecycleState.resumed) {
      _log.i('Lifecycle: resumed → _connect()');
      _connect();
    } else if (state == AppLifecycleState.paused) {
      _log.i('Lifecycle: paused → _disconnect()');
      // 백그라운드에서도 유지하고 싶다면 아래 라인을 주석 처리
      _disconnect();
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disconnect();
  }

  // ========= SSE 연결/해제 =========

  void _connect() {
    _log.i('try _connect: hasSub=${_sseSub != null}, baseUrl=$_baseUrl, hasToken=${_token != null}');
    if (_sseSub != null) {
      _log.w('_connect() skipped: already connected');
      return;
    }
    if (_baseUrl == null || _token == null) {
      _log.w('_connect() skipped: baseUrl/token missing');
      return;
    }

    final url = '$_baseUrl/s/api/notifications/connect';
    // 서버가 "Bearer xxx" 형태로 주므로 그대로 사용
    final headers = {'Authorization': _token!};

    _log.i('SSE connect -> $url');
    final masked = Map.of(headers)..['Authorization'] = 'Bearer ***';
    _log.i('SSE headers -> $masked');

    _sseSub =
        SSEClient.subscribeToSSE(
          method: SSERequestType.GET,
          url: url,
          header: headers,
        ).listen(
          (event) async {
            final id = event.id ?? '';
            final name = event.event ?? '';
            final data = event.data ?? '';

            _log.d('[SSE] id=$id, event=$name, len=${data}');

            // connect / ping 은 연결 성공으로 간주하지 않음
            if (name.isEmpty || name == 'connect' || name == 'ping') return;

            if (name != 'notification') {
              _log.d('[SSE] ignore event=$name');
              return;
            }
            if (data.isEmpty) return;

            final trimmed = data.trimLeft();
            if (!(trimmed.startsWith('{') || trimmed.startsWith('['))) {
              _log.w('[SSE] not JSON, skip: $trimmed');
              return;
            }

            try {
              final decoded = jsonDecode(trimmed);
              final json = decoded is Map<String, dynamic> ? decoded : <String, dynamic>{'payload': decoded};

              // 실제 유의미 이벤트 수신 시에만 성공으로 간주
              _retry = 0;

              final (title, body) = _makeTitleAndBody(json);
              _log.i('[SSE] notify -> $title | $body');
              await _showLocalNotification(title: title, body: body, payload: json);
            } catch (e, st) {
              _log.w('[SSE] JSON parse fail', e, st);
            }
          },
          onError: (e, st) {
            _log.w('[SSE] error', e, st);
            _scheduleReconnect();
          },
          onDone: () {
            _log.w('[SSE] done');
            _scheduleReconnect();
          },
          cancelOnError: true,
        );
  }

  void _disconnect() {
    _log.i('SSE disconnect');
    _sseSub?.cancel();
    _sseSub = null;
  }

  void _scheduleReconnect() {
    _disconnect();
    if (_token == null) return;

    _retry = (_retry == 0) ? 1 : (_retry * 2);
    final delay = Duration(seconds: _retry.clamp(1, 30));
    _log.i('재연결 예약: ${delay.inSeconds}s 후');
    Future.delayed(delay, () {
      if (_token != null && _sseSub == null) {
        _connect();
      }
    });
  }

  // ========= 로컬 알림 =========

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    final android = AndroidNotificationDetails(
      _channel.id,
      _channel.name,
      channelDescription: _channel.description,
      importance: Importance.high,
      priority: Priority.high,
      styleInformation: const DefaultStyleInformation(true, true),
    );

    final details = NotificationDetails(android: android);
    final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await _flnp.show(
      id,
      null,
      body,
      details,
      payload: payload == null ? null : jsonEncode(payload),
    );
  }

  // ========= 탭 핸들링 =========

  void _handleNotificationTap(Map<String, dynamic> payload) {
    final nav = _navKey?.currentState;
    if (nav == null) return;

    final type = payload['type'] as String?;
    switch (type) {
      case 'STORY_LIKED':
        nav.push(MaterialPageRoute(builder: (_) => StoryDetailPage(storyId: payload['storyId'])));
        break;
      case 'POST_LIKED':
      case 'COMMENTED':
        nav.push(MaterialPageRoute(builder: (_) => PostDetailPage(postId: payload['postId'])));
        break;
      case 'FOLLOWED':
        nav.push(MaterialPageRoute(builder: (_) => ProfilePage(userId: payload['followerId'])));
        break;
      default:
        nav.pushNamed(MRoute.notification);
    }
  }

  // ========= 메시지 → 타이틀/본문 =========

  (String, String) _makeTitleAndBody(Map<String, dynamic> json) {
    final type = json['type'] as String?;
    final sender = json['sender'] as Map<String, dynamic>?;
    final username = sender?['username'] ?? '누군가';

    String title = '알림';
    String body = '새로운 활동이 있습니다.';

    switch (type) {
      case 'STORY_LIKED':
        body = '$username 님이 회원님의 스토리를 좋아합니다.';
        break;
      case 'POST_LIKED':
        body = '$username 님이 회원님의 게시글을 좋아합니다.';
        break;
      case 'COMMENTED':
        body = '$username 님이 회원님의 게시글에 댓글을 남겼습니다.';
        break;
      case 'FOLLOWED':
        body = '$username 님이 회원님을 팔로우하기 시작했습니다.';
        break;
      default:
        body = '$username 의 새로운 활동';
    }
    return (title, body);
  }
}

class NotificationBootstrapper extends ConsumerWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;
  const NotificationBootstrapper({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // build 안에서만 사용
    ref.listen<SessionModel>(
      sessionProvider,
      (prev, next) async {
        final token = next.user?.accessToken; // 서버에서 "Bearer xxx"
        final baseUrl = dio.options.baseUrl;

        if (token != null && token.isNotEmpty) {
          await NotificationCenter.instance.ensureInitialized(navigatorKey);
          NotificationCenter.instance.updateAuth(baseUrl: baseUrl, token: token);
        } else {
          NotificationCenter.instance.updateAuth(baseUrl: baseUrl, token: null);
        }
      },
    );

    return child;
  }
}
