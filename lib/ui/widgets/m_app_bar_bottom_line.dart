import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MAppBarBottomLine extends StatelessWidget implements PreferredSizeWidget {
  const MAppBarBottomLine({
    super.key,
  });

  @override
  Size get preferredSize => Size.fromHeight(MSize.kLine.normal);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MColor.kLine.main,
      height: MSize.kLine.normal,
    );
  }
}
