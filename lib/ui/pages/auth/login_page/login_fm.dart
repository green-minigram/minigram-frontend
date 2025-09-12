import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/util/validator_util.dart';

/// 1. 창고 관리자
final loginProvider = AutoDisposeNotifierProvider<LoginFM, LoginModel>(() {
  return LoginFM();
});

/// 2. 창고
class LoginFM extends AutoDisposeNotifier<LoginModel> {
  @override
  LoginModel build() {
    return LoginModel("", "", "", "");
  }

  void email(String email) {
    final error = validateEmail(email);
    state = state.copyWith(email: email, emailError: error);
  }

  void password(String password) {
    final error = validatePassword(password);
    state = state.copyWith(password: password, passwordError: error);
  }

  bool validate() {
    final emailError = validateEmail(state.email);
    final passwordError = validatePassword(state.password);

    return emailError.isEmpty && passwordError.isEmpty;
  }
}

/// 3. 창고 데이터 타입
class LoginModel {
  final String email;
  final String password;

  final String emailError;
  final String passwordError;

  LoginModel(
    this.email,
    this.password,
    this.emailError,
    this.passwordError,
  );

  LoginModel copyWith({
    String? email,
    String? password,
    String? emailError,
    String? passwordError,
  }) {
    return LoginModel(
      email ?? this.email,
      password ?? this.password,
      emailError ?? this.emailError,
      passwordError ?? this.passwordError,
    );
  }

  @override
  String toString() {
    return 'LoginModel{username: $email, password: $password, usernameError: $emailError, passwordError: $passwordError}';
  }
}
