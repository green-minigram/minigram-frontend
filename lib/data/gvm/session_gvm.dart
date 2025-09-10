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
import 'package:minigram/ui/pages/auth/login_page/login_page.dart';

/// 1. 창고 관리자
final sessionProvider = NotifierProvider<SessionGVM, SessionModel>(() {
  return SessionGVM();
});

/// 2. 창고
class SessionGVM extends Notifier<SessionModel> {
  final mContext = navigatorKey.currentContext!;

  @override
  SessionModel build() {
    return SessionModel();
  }

  Future<void> join(String username, String email, String password) async {
    Logger().d("username : $username, email : $email, password : $password");
    final fm = ref.read(joinProvider.notifier);

    // 폼 기본 검증 + 서버 가용성 확인
    final ok = fm.validateWithAvailability();
    if (!ok) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(content: Text("유효성 혹은 중복검사 확인이 필요합니다.")),
      );
      return;
    }

    // 로딩 시작
    state = SessionModel(user: state.user, isLogin: state.isLogin, isJoining: true);

    try {
      final body = await UserRepository().join(username, email, password);
      if (body["status"] != 200) {
        ScaffoldMessenger.of(mContext).showSnackBar(
          SnackBar(content: Text("${body["msg"]}")),
        );
        return;
      }

      // 성공 → 로그인 화면으로 스택 정리 이동
      Navigator.pushNamedAndRemoveUntil(mContext, MRoute.login, (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        const SnackBar(content: Text("일시적인 오류가 발생했습니다. 잠시 후 다시 시도해주세요.")),
      );
    } finally {
      // 화면 전환 직전/직후에도 안전하게 false
      state = SessionModel(user: state.user, isLogin: state.isLogin, isJoining: false);
    }
  }

  // 이하 login/logout/autoLogin 기존 코드 유지
  // Future<void> login(String username, String password) async {
  //   // 1. 유효성 검사
  //   Logger().d("username : ${username}, password : ${password}");
  //   bool isValid = ref.read(loginProvider.notifier).validate();
  //   if (!isValid) {
  //     ScaffoldMessenger.of(mContext).showSnackBar(
  //       SnackBar(content: Text("유효성 검사 실패입니다")),
  //     );
  //     return;
  //   }
  //
  //   // 2. 통신
  //   Map<String, dynamic> body = await UserRepository().login(username, password);
  //   if (!body["success"]) {
  //     ScaffoldMessenger.of(mContext).showSnackBar(
  //       SnackBar(content: Text("${body["errorMessage"]}")),
  //     );
  //     return;
  //   }
  //
  //   // 3. 파싱
  //   User user = User.fromMap(body["response"]);
  //
  //   // 4. 토큰을 디바이스 저장
  //   // 스플레쉬 화면에서 자동로그인 구현에 사용
  //   await secureStorage.write(key: "accessToken", value: user.accessToken);
  //
  //   // 5. 세션모델 갱신
  //   state = SessionModel(user: user, isLogin: true);
  //
  //   // 5. dio의 header에 토큰 세팅 [Bearer <- 이거 들어가 있음]
  //   dio.options.headers["Authorization"] = user.accessToken;
  //
  //   // 6. 게시글 목록 페이지 이동
  //   Navigator.pushNamed(mContext, "/post/list");
  // }

  Future<void> logout() async {
    // 1. 토큰 디바이스 제거
    await secureStorage.delete(key: "accessToken");

    // 2. 세션모델 초기화
    state = SessionModel();

    // 3. dio 세팅 제거
    dio.options.headers.remove("Authorization");

    // 4. login 페이지 이동
    Navigator.pushNamedAndRemoveUntil(mContext, MRoute.login, (route) => false);
  }

  Future<void> autoLogin() async {
    // 디바이스에서 토큰 값 가져오기
    String? accessToken = await secureStorage.read(key: "accessToken");

    if (accessToken == null) {
      Navigator.pushReplacement(mContext, MaterialPageRoute(builder: (_) => LoginPage()));
      return;
    }

    // 1. 통신
    Map<String, dynamic> body = await UserRepository().autoLogin(accessToken);

    if (!body["success"]) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("${body["errorMessage"]}")),
      );
      Navigator.pushReplacement(mContext, MaterialPageRoute(builder: (_) => LoginPage()));
      return;
    }

    User user = User.fromMap(body["response"]);
    user.accessToken = accessToken;

    // 5. 세션모델 갱신
    state = SessionModel(user: user, isLogin: true);

    // 5. dio의 header에 토큰 세팅 [Bearer <- 이거 들어가 있음]
    dio.options.headers["Authorization"] = user.accessToken;

    // 6. 게시글 목록 페이지 이동
    Navigator.pushNamedAndRemoveUntil(mContext, MRoute.mainHolder, (route) => route.isFirst);
  }
}

/// 3. 창고 데이터 타입 (불변 아님)
class SessionModel {
  User? user;
  bool? isLogin;
  bool isJoining; // 회원가입 진행 중

  SessionModel({this.user, this.isLogin = false, this.isJoining = false});

  @override
  String toString() {
    return 'SessionModel{user: $user, isLogin: $isLogin, isJoining: $isJoining}';
  }
}
