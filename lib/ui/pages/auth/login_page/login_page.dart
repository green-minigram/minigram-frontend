import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/auth/login_page/widgets/login_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginBody(),
    );
  }
}
