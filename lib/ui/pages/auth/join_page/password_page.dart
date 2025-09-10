import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/auth/join_page/widgets/form_app_bar.dart';
import 'package:minigram/ui/pages/auth/join_page/widgets/password_body.dart';

class PasswordPage extends StatelessWidget {
  const PasswordPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(
        titleText: "회원가입",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: PasswordBody(),
    );
  }
}
