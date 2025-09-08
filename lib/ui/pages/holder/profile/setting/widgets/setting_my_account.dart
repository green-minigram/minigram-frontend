import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class SettingMyAccount extends StatelessWidget {
  const SettingMyAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "내 계정",
          style: TextStyle(color: MColor.kText.description, fontWeight: FontWeight.bold, fontSize: MSize.kFont.m),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {},
          leading: Icon(
            Icons.account_circle_outlined,
            size: MSize.kIcon.xl,
          ),
          title: Text(
            "계정 센터",
            style: TextStyle(fontSize: MSize.kFont.l, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "비밀번호",
            style: TextStyle(color: MColor.kText.secondary, fontSize: MSize.kFont.m, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: MSize.kIcon.s,
          ),
        ),
      ],
    );
  }
}
