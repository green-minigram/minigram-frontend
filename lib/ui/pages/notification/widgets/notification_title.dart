import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';

class NotificationTitle extends StatelessWidget {
  final String title;

  const NotificationTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MSize.kGap.l,
        vertical: MSize.kGap.xs,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: MSize.kFont.l,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
