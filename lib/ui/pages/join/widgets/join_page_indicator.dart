import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class JoinPageIndicator extends StatelessWidget {
  const JoinPageIndicator({
    super.key,
    required this.pageNum,
  });

  final int pageNum;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: MSize.kGap.xxxs,
      children: List.generate(3, (index) {
        return Container(
          width: 24,
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: index == pageNum ? MColor.kButton.primary : MColor.kButton.disabled,
          ),
        );
      }),
    );
  }
}
