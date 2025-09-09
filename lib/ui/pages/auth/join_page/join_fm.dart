import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/util/validator_util.dart';

/// 1. 창고 관리자
final joinProvider = NotifierProvider<JoinFM, JoinModel>(() {
  return JoinFM();
});

/// 2. 창고
class JoinFM extends Notifier<JoinModel> {
  @override
  JoinModel build() {
    return JoinModel("", "", "", "", "", "", "", ""); // 파라미터 추가
  }

  void username(String username) {
    final error = validateUsername(username);
    state = state.copyWith(username: username, usernameError: error);
  }

  void email(String email) {
    final error = validateEmail(email);
    state = state.copyWith(email: email, emailError: error);
  }

  void password(String password) {
    final error = validatePassword(password);
    state = state.copyWith(password: password, passwordError: error);
  }

  void passwordConfirm(String passwordConfirm) {
    final error = validatePasswordConfirm(state.password, passwordConfirm);
    state = state.copyWith(passwordConfirm: passwordConfirm, passwordConfirmError: error);
  }

  bool emailValidate() {
    final emailError = validateEmail(state.email);
    return emailError.isEmpty;
  }

  bool usernameValidate() {
    final usernameError = validateUsername(state.username);
    return usernameError.isEmpty;
  }

  bool validate() {
    final usernameError = validateUsername(state.username);
    final emailError = validateEmail(state.email);
    final passwordError = validatePassword(state.password);
    final passwordConfirmError = validatePasswordConfirm(state.password, state.passwordConfirm);

    return usernameError.isEmpty && emailError.isEmpty && passwordError.isEmpty && passwordConfirmError.isEmpty;
  }
}

/// 3. 창고 데이터 타입
class JoinModel {
  final String username;
  final String email;
  final String password;
  final String passwordConfirm; // 추가

  final String usernameError;
  final String emailError;
  final String passwordError;
  final String passwordConfirmError; // 추가

  JoinModel(
    this.username,
    this.email,
    this.password,
    this.passwordConfirm, // 추가
    this.usernameError,
    this.emailError,
    this.passwordError,
    this.passwordConfirmError, // 추가
  );

  JoinModel copyWith({
    String? username,
    String? email,
    String? password,
    String? passwordConfirm, // 추가
    String? usernameError,
    String? emailError,
    String? passwordError,
    String? passwordConfirmError, // 추가
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
    );
  }

  @override
  String toString() {
    return 'JoinModel{username: $username, email: $email, password: $password, passwordConfirm: $passwordConfirm, usernameError: $usernameError, emailError: $emailError, passwordError: $passwordError, passwordConfirmError: $passwordConfirmError}';
  }
}
