import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/join/widgets/form_app_bar.dart';
import 'package:minigram/ui/pages/join/widgets/username_body.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FormAppBar(
        titleText: "회원가입",
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: UsernameBody(),
    );
  }
}
