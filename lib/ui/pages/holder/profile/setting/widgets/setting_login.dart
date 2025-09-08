import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class SettingLogin extends StatelessWidget {
  const SettingLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "로그인",
          style: TextStyle(color: MColor.kText.description, fontWeight: FontWeight.bold, fontSize: MSize.kFont.m),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {},
          title: Text(
            "로그아웃",
            style: TextStyle(fontSize: MSize.kFont.l, fontWeight: FontWeight.bold, color: MColor.kText.red),
          ),
        ),
      ],
    );
  }
}
