import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/util/validator_util.dart';
import 'package:minigram/data/repository/user_repository.dart';
import 'package:minigram/ui/pages/auth/join_page/join_email_handler.dart';
import 'package:minigram/ui/pages/auth/join_page/join_username_handler.dart';

/// 1. 창고 관리자
final joinProvider = AutoDisposeNotifierProvider<JoinFM, JoinModel>(() {
  return JoinFM();
});

/// 2. 창고
class JoinFM extends AutoDisposeNotifier<JoinModel> {
  Timer? _usernameDebounce; // 디바운싱 처리용 객체
  Timer? _emailDebounce; // 디바운싱 처리용 객체

  int _usernameRequestToken = 0; // 요청 순서 식별용.
  int _emailRequestToken = 0; // 요청 순서 식별용

  @override
  JoinModel build() {
    // onDispose에서 타이머 정리
    ref.onDispose(() {
      _usernameDebounce?.cancel();
      _emailDebounce?.cancel();
    });

    return JoinModel(
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      "",
      isUsernameChecking: false,
      isEmailChecking: false,
      isUsernameAvailable: null,
      isEmailAvailable: null,
    );
  }

  // 디바운싱 포함
  void username(String username) {
    final error = validateUsername(username);
    // 로컬 에러 먼저 반영
    state = state.copyWith(
      username: username,
      usernameError: error,
      // 입력이 바뀌면 이전 결과는 무효 처리(미확정)
      isUsernameAvailable: null,
    );

    // 유효하지 않으면 서버 체크 스킵
    _usernameDebounce?.cancel();
    if (username.isEmpty || error.isNotEmpty) {
      state = state.copyWith(isUsernameChecking: false);
      return;
    }

    // 디바운스 시작
    state = state.copyWith(isUsernameChecking: true);
    final current = ++_usernameRequestToken;

    _usernameDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final available = await UserRepository().checkUsernameAvailable(username);
        // 최신 요청만 반영
        if (current == _usernameRequestToken) {
          state = state.copyWith(
            isUsernameChecking: false,
            isUsernameAvailable: available,
            usernameError: available ? "" : "이미 사용 중인 아이디입니다.",
          );
        }
      } catch (_) {
        if (current == _usernameRequestToken) {
          state = state.copyWith(
            isUsernameChecking: false,
            isUsernameAvailable: null, // 미확정(네트워크 오류 등)
          );
        }
      }
    });
  }

  // 디바운싱 포함
  void email(String email) {
    final error = validateEmail(email);
    state = state.copyWith(
      email: email,
      emailError: error,
      isEmailAvailable: null,
    );

    _emailDebounce?.cancel();
    if (email.isEmpty || error.isNotEmpty) {
      state = state.copyWith(isEmailChecking: false);
      return;
    }

    state = state.copyWith(isEmailChecking: true);
    final current = ++_emailRequestToken;

    _emailDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        final available = await UserRepository().checkEmailAvailable(email);
        if (current == _emailRequestToken) {
          state = state.copyWith(
            isEmailChecking: false,
            isEmailAvailable: available,
            emailError: available ? "" : "이미 사용 중인 이메일입니다.",
          );
        }
      } catch (_) {
        if (current == _emailRequestToken) {
          state = state.copyWith(
            isEmailChecking: false,
            isEmailAvailable: null,
          );
        }
      }
    });
  }

  void password(String password) {
    final error = validatePassword(password);
    state = state.copyWith(password: password, passwordError: error);
  }

  void passwordConfirm(String passwordConfirm) {
    final error = validatePasswordConfirm(state.password, passwordConfirm);
    state = state.copyWith(passwordConfirm: passwordConfirm, passwordConfirmError: error);
  }

  void confirmEmail() {
    confirmEmailFlow(
      state: state,
      // 에러 문구를 상태에 반영하는 최소한의 쓰기 콜백
      syncEmailError: (err) => state = state.copyWith(emailError: err),
    );
  }

  void confirmUsername() {
    confirmUsernameFlow(
      state: state,
      // 에러 문구를 상태에 반영하는 최소한의 쓰기 콜백
      syncUsernameError: (err) => state = state.copyWith(usernameError: err),
    );
  }

  // 모든 input 데이터 검증 확인
  bool validate() {
    final usernameError = validateUsername(state.username);
    final emailError = validateEmail(state.email);
    final passwordError = validatePassword(state.password);
    final passwordConfirmError = validatePasswordConfirm(state.password, state.passwordConfirm);
    return usernameError.isEmpty && emailError.isEmpty && passwordError.isEmpty && passwordConfirmError.isEmpty;
  }

  // 서버 가용성까지 포함한 최종 검증 (제출 버튼 활성화/차단용)
  bool validateWithAvailability() {
    final basic = validate();
    final usernameOk = state.isUsernameAvailable == true && !state.isUsernameChecking;
    final emailOk = state.isEmailAvailable == true && !state.isEmailChecking;
    return basic && usernameOk && emailOk;
  }
}

/// 3. 창고 데이터 타입
class JoinModel {
  final String username;
  final String email;
  final String password;
  final String passwordConfirm;

  final String usernameError;
  final String emailError;
  final String passwordError;
  final String passwordConfirmError;

  // 서버 중복체크 상태
  final bool isUsernameChecking;
  final bool isEmailChecking;

  // null=미확정, true=가용, false=중복
  final bool? isUsernameAvailable;
  final bool? isEmailAvailable;

  JoinModel(
    this.username,
    this.email,
    this.password,
    this.passwordConfirm,
    this.usernameError,
    this.emailError,
    this.passwordError,
    this.passwordConfirmError, {
    required this.isUsernameChecking,
    required this.isEmailChecking,
    required this.isUsernameAvailable,
    required this.isEmailAvailable,
  });

  JoinModel copyWith({
    String? username,
    String? email,
    String? password,
    String? passwordConfirm,
    String? usernameError,
    String? emailError,
    String? passwordError,
    String? passwordConfirmError,
    bool? isUsernameChecking,
    bool? isEmailChecking,
    bool? isUsernameAvailable,
    bool? isEmailAvailable,
  }) {
    return JoinModel(
      username ?? this.username,
      email ?? this.email,
      password ?? this.password,
      passwordConfirm ?? this.passwordConfirm,
      usernameError ?? this.usernameError,
      emailError ?? this.emailError,
      passwordError ?? this.passwordError,
      passwordConfirmError ?? this.passwordConfirmError,
      isUsernameChecking: isUsernameChecking ?? this.isUsernameChecking,
      isEmailChecking: isEmailChecking ?? this.isEmailChecking,
      isUsernameAvailable: isUsernameAvailable ?? this.isUsernameAvailable,
      isEmailAvailable: isEmailAvailable ?? this.isEmailAvailable,
    );
  }

  @override
  String toString() {
    return 'JoinModel{username: $username, email: $email, password: $password, passwordConfirm: $passwordConfirm, usernameError: $usernameError, emailError: $emailError, passwordError: $passwordError, passwordConfirmError: $passwordConfirmError, isUsernameChecking: $isUsernameChecking, isEmailChecking: $isEmailChecking, isUsernameAvailable: $isUsernameAvailable, isEmailAvailable: $isEmailAvailable}';
  }
}
