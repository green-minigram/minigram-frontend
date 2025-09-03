import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/join/widgets/m_form_app_bar.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class FormEmailPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MFormAppBar(
        titleText: "회원가입",
        onLeadingPressed: () {
          // Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MSizes.kGap.l),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    SizedBox(height: MSizes.kGap.l),
                    MAuthTextFormField(title: "이메일"),
                    SizedBox(height: MSizes.kGap.l),
                    MButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/join/form-username");
                      },
                      text: "다음",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
