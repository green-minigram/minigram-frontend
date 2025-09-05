import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileHeaderBio extends StatelessWidget {
  const ProfileHeaderBio({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MSize.kGap.m),
      child: Text(
        "자기소개",
        style: TextStyle(fontSize: MSize.kFont.m),
      ),
    );
  }
}
