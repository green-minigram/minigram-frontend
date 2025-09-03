import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/join/widgets/form_app_bar.dart';
import 'package:minigram/ui/pages/join/widgets/password_body.dart';

class PasswordPage extends StatelessWidget {
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
