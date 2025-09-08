import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class SettingAdmin extends StatelessWidget {
  const SettingAdmin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "관리자",
          style: TextStyle(color: MColor.kText.description, fontWeight: FontWeight.bold, fontSize: MSize.kFont.m),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            Navigator.pushNamed(context, "/abuse-report");
          },
          title: Text(
            "신고 내역",
            style: TextStyle(fontSize: MSize.kFont.l, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
