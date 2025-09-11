import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/auth/login_page/widgets/custom_logo.dart';
import 'package:minigram/ui/pages/auth/login_page/widgets/login_form.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class LoginBody extends StatelessWidget {
  final scrollController = ScrollController();

  // 새 계정 만들기 버튼의 onPressed 이벤트를 위한 함수
  void _onJoinPressed(BuildContext context) {
    Navigator.pushNamed(context, MRoute.joinEmail);
  }

  // MAuthTextFormField의 onTap 이벤트를 위한 함수
  Future<void> _onFieldTapped() async {
    await Future.delayed(const Duration(milliseconds: 600));
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              controller: scrollController,
              children: [
                CustomLogo(),
                SizedBox(height: MSize.kGap.l),
                LoginForm(onFieldTapped: _onFieldTapped),
              ],
            ),
          ),
          MButton.outline(
            text: "새 계정 만들기",
            textColor: MColor.kText.blue,
            borderSide: BorderSide(color: MColor.kLine.main),
            backgroundColor: MColor.kBackGround.normal,
            onPressed: () {
              _onJoinPressed(context);
            },
          ),
          SizedBox(height: MSize.kGap.doubleHuge),
        ],
      ),
    );
  }
}
