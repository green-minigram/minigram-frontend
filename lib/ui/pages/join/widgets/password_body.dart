import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class PasswordBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
            child: Form(
              child: ListView(
                children: [
                  SizedBox(height: MSize.kGap.l),
                  MAuthTextFormField(
                    title: "비밀번호",
                    hintText: "비밀번호를 입력해주세요",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: MSize.kGap.l),
                  MAuthTextFormField(
                    title: "비밀번호",
                    hintText: "비밀번호를 확인해주세요",
                    disableTitle: true,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  SizedBox(height: MSize.kGap.l),
                  MButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MRoute.login);
                    },
                    text: "완료",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
