import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class LoginBody extends StatelessWidget {
  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSizes.kGap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: Form(
              child: ListView(
                controller: scroll,
                children: [
                  Container(
                    color: Colors.black26,
                    height: 300,
                  ),
                  SizedBox(height: MSizes.kGap.l),
                  MAuthTextFormField(
                    hintText: "이메일",
                    keyboardType: TextInputType.emailAddress,
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 600));
                      scroll.jumpTo(scroll.position.maxScrollExtent);
                    },
                  ),
                  SizedBox(height: MSizes.kGap.l),
                  MAuthTextFormField(
                    hintText: "비밀번호",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTap: () async {
                      await Future.delayed(Duration(milliseconds: 600));
                      scroll.jumpTo(scroll.position.maxScrollExtent);
                    },
                  ),
                  SizedBox(height: MSizes.kGap.l),
                  MButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, MRoute.joinUsername);
                    },
                    text: "로그인",
                  ),
                  SizedBox(height: MSizes.kGap.l),
                ],
              ),
            ),
          ),
          MButton.outline(
            onPressed: () {
              Navigator.pushNamed(context, MRoute.joinEmail);
            },
            text: "새 계정 만들기",
            textColor: MColor.kText.blue,
            borderSide: BorderSide(color: MColor.kLine.main),
            backgroundColor: MColor.kBackGround.normal,
          ),
          SizedBox(height: MSizes.kGap.doubleHuge),
        ],
      ),
    );
  }
}
