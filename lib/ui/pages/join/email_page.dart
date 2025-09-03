import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/join/widgets/email_body.dart';
import 'package:minigram/ui/pages/join/widgets/form_app_bar.dart';

class EmailPage extends StatelessWidget {
  const EmailPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(
        titleText: "회원가입",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: EmailBody(),
    );
  }
}
