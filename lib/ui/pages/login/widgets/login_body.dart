import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class LoginBody extends StatelessWidget {
  final scroll = ScrollController();

  // MAuthTextFormField의 onTap 이벤트를 위한 함수
  Future<void> _onFieldTapped() async {
    await Future.delayed(const Duration(milliseconds: 600));
    scroll.jumpTo(scroll.position.maxScrollExtent);
  }

  // 로그인 버튼의 onPressed 이벤트를 위한 함수
  void _onLoginPressed(context) {
    Navigator.pushNamedAndRemoveUntil(context, MRoute.mainHolder, (route) => route.isFirst);
  }

  // 새 계정 만들기 버튼의 onPressed 이벤트를 위한 함수
  void _onJoinPressed(BuildContext context) {
    Navigator.pushNamed(context, MRoute.joinEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
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
                  SizedBox(height: MSize.kGap.l),
                  MAuthTextFormField(
                    hintText: "이메일",
                    keyboardType: TextInputType.emailAddress,
                    onTap: _onFieldTapped,
                  ),
                  SizedBox(height: MSize.kGap.l),
                  MAuthTextFormField(
                    hintText: "비밀번호",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onTap: _onFieldTapped,
                  ),
                  SizedBox(height: MSize.kGap.l),
                  MButton(
                    onPressed: () {
                      _onLoginPressed(context);
                    },
                    text: "로그인",
                  ),
                  SizedBox(height: MSize.kGap.l),
                ],
              ),
            ),
          ),
          MButton.outline(
            onPressed: () => _onJoinPressed(context),
            text: "새 계정 만들기",
            textColor: MColor.kText.blue,
            borderSide: BorderSide(color: MColor.kLine.main),
            backgroundColor: MColor.kBackGround.normal,
          ),
          SizedBox(height: MSize.kGap.doubleHuge),
        ],
      ),
    );
  }
}
