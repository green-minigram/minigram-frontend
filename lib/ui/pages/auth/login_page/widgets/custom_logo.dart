import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MColor.kBackGround.normal,
      height: 300,
      child: Image.asset(
        "assets/logo/instagram.png",
      ),
    );
  }
}
