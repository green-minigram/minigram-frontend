import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class EmailBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSizes.kGap.l),
      child: Column(
        children: [
          Flexible(
            child: Form(
              child: ListView(
                children: [
                  SizedBox(height: MSizes.kGap.l),
                  MAuthTextFormField(
                    title: "이메일",
                    hintText: "이메일을 입력해주세요",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: MSizes.kGap.l),
                  MButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MRoute.joinUsername);
                    },
                    text: "다음",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
