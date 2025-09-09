import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/auth/join_page/widgets/join_page_indicator.dart';
import 'package:minigram/ui/widgets/m_auth_text_form_field.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class UsernameBody extends StatelessWidget {
  int pageNum = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      child: Column(
        children: [
          JoinPageIndicator(pageNum: pageNum),
          Flexible(
            child: Form(
              child: ListView(
                children: [
                  SizedBox(height: MSize.kGap.l),
                  MAuthTextFormField(
                    title: "아이디",
                    hintText: "아이디를 입력해주세요",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: MSize.kGap.l),
                  MButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MRoute.joinPassword);
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
