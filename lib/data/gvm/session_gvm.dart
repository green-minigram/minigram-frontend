import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/_core/util/m_device.dart';
import 'package:minigram/_core/util/my_http.dart';
import 'package:minigram/data/model/user.dart';
import 'package:minigram/data/repository/user_repository.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/main.dart';
import 'package:minigram/ui/pages/auth/join_page/join_fm.dart';
import 'package:minigram/ui/pages/auth/login_page/login_fm.dart';
import 'package:minigram/ui/pages/auth/login_page/login_page.dart';

/// 1. 창고 관리자
final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(() {
  return SessionGVM();
});

/// 2. 창고
class SessionGVM extends Notifier<SessionModel> {
  BuildContext? mContext; // nullable

  @override
  SessionModel build() {
    return SessionModel();
  }

  void setContext(BuildContext ctx) {
    mContext = ctx;
  }

  void _showSnack(String msg) {
    if (mContext != null) {
      ScaffoldMessenger.of(mContext!).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  // ---- 네비 헬퍼 (navigatorKey 기반) ----
  NavigatorState? get _nav => navigatorKey.currentState;

  // 프레임 뒤로 미뤄서 attach 안 된 시점도 안전하게
  void _withNav(void Function(NavigatorState nav) fn) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = _nav;
      if (nav != null) fn(nav);
    });
  }

  void _goNamedAndRemoveAll(String routeName) {
    _withNav((nav) => nav.pushNamedAndRemoveUntil(routeName, (r) => false));
  }

  void _goNamedKeepingFirst(String routeName) {
    _withNav((nav) => nav.pushNamedAndRemoveUntil(routeName, (r) => r.isFirst));
  }

  void _pushReplacementPage(Widget page) {
    _withNav(
      (nav) => nav.pushReplacement(
        MaterialPageRoute(builder: (_) => page),
      ),
    );
  }

  // 선택지 A: 제출 전 과정을 한 곳에서 처리
  Future<void> join() async {
    final fm = ref.read(joinProvider.notifier);
    final s = ref.read(joinProvider);

    // 1) 비밀번호 가드(스낵바 & 폼 에러 동기화는 fm.confirmPassword 내부 처리)
    final passwordOk = fm.confirmPassword();
    if (!passwordOk) return;

    // 2) 최종 검증(이메일/아이디 가용성 포함)
    Logger().d("join submit -> username:${s.username}, email:${s.email}");
    final ok = fm.validateWithAvailability();
    if (!ok) {
      _showSnack("이메일, 아이디, 비밀번호를 확인해주세요");
      return;
    }

    // 3) 로딩 시작(버튼 스피너 표시용)

    try {
      // 4) 가입 호출(현재 2초 더미 딜레이 포함)
      state = SessionModel(isJoining: true);
      final body = await UserRepository().join(s.username, s.email, s.password);
      if (body["status"] != 200) {
        _showSnack("${body["msg"]}");
        return;
      }

      // 5) 성공 → 로그인으로 스택 초기화 이동
      _goNamedAndRemoveAll(MRoute.login);
      // Navigator.pushNamedAndRemoveUntil(
      //   mContext,
      //   MRoute.login,
      //   (route) => false,
      // );
    } catch (e) {
      _showSnack("일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
    } finally {
      // 6) 로딩 종료(전환 직전/직후에도 안전하게 false)
      state = SessionModel(isJoining: false);
    }
  }

  Future<void> login(String email, String password) async {
    // 1. 유효성 검사
    Logger().d("email : ${email}, password : ${password}");
    bool isValid = ref.read(loginProvider.notifier).validate();
    if (!isValid) {
      _showSnack("유효성 검사 실패입니다.");
      return;
    }

    // 로그인 진행 상태
    state = SessionModel(isLoggingIn: true);

    // 2. 통신
    Map<String, dynamic> body = await UserRepository().login(email, password);
    if (body["status"] != 200) {
      _showSnack("${body["msg"]}");
      return;
    }

    // 3. 파싱
    User user = User.fromMap(body["body"]);

    // 4. 토큰을 디바이스 저장
    // 스플레쉬 화면에서 자동로그인 구현에 사용
    await secureStorage.write(key: "accessToken", value: user.accessToken);

    // 5. 세션모델 갱신
    state = SessionModel(user: user, isLogin: true, isLoggingIn: false);

    // 5. dio의 header에 토큰 세팅 [Bearer <- 이거 들어가 있음]
    dio.options.headers["Authorization"] = user.accessToken;

    Logger().d("로그인 성공");

    // 6. 게시글 목록 페이지 이동
    // Navigator.pushNamedAndRemoveUntil(
    //   mContext,
    //   MRoute.mainHolder,
    //   (route) => false,
    // );
    _goNamedAndRemoveAll(MRoute.mainHolder);
  }

  Future<void> logout() async {
    // 1. 토큰 디바이스 제거
    await secureStorage.delete(key: "accessToken");

    // 2. 세션모델 초기화
    state = SessionModel();

    // 3. dio 세팅 제거
    dio.options.headers.remove("Authorization");

    Logger().d("로그아웃 성공");

    // 4. login 페이지 이동
    //Navigator.pushNamedAndRemoveUntil(mContext, MRoute.login, (route) => false);
    _goNamedAndRemoveAll(MRoute.login);
  }

  Future<void> autoLogin() async {
    // 디바이스에서 토큰 값 가져오기
    String? accessToken = await secureStorage.read(key: "accessToken");

    if (accessToken == null) {
      // Navigator.pushReplacement(
      //   mContext,
      //   MaterialPageRoute(builder: (_) => LoginPage()),
      // );
      _pushReplacementPage(LoginPage());
      return;
    }

    // 1. 통신
    Map<String, dynamic> body = await UserRepository().autoLogin(accessToken);

    if (!body["success"]) {
      _showSnack("${body["errorMessage"]}");
      // Navigator.pushReplacement(
      //   mContext,
      //   MaterialPageRoute(builder: (_) => LoginPage()),
      // );
      _pushReplacementPage(LoginPage());
      return;
    }

    User user = User.fromMap(body["response"]);
    user.accessToken = accessToken;

    // 5. 세션모델 갱신
    state = SessionModel(user: user, isLogin: true);

    // 5. dio의 header에 토큰 세팅 [Bearer <- 이거 들어가 있음]
    dio.options.headers["Authorization"] = user.accessToken;

    // 6. 게시글 목록 페이지 이동
    // Navigator.pushNamedAndRemoveUntil(
    //   mContext,
    //   MRoute.mainHolder,
    //   (route) => route.isFirst,
    // );
    _goNamedKeepingFirst(MRoute.mainHolder);
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class SessionModel {
  User? user;
  bool isLogin;
  bool isJoining; // 회원가입 진행 중
  bool isLoggingIn; // 로그인 진행 중

  SessionModel({
    this.user,
    this.isLogin = false,
    this.isJoining = false,
    this.isLoggingIn = false,
  });

  @override
  String toString() {
    return 'SessionModel{user: $user, isLogin: $isLogin, isJoining: $isJoining, isLoggingIn: $isLoggingIn}';
  }
}
