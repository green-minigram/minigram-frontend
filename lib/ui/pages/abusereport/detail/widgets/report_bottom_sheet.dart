import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class ReportBottomSheet extends StatelessWidget {
  const ReportBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l, vertical: MSize.kGap.xxl),
      decoration: BoxDecoration(
        color: MColor.kBackGround.normal,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: Offset(0, -2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        spacing: MSize.kGap.m,
        children: [
          Text("신고 사유", style: TextStyle(fontSize: MSize.kFont.xxxl)),
          Text("마음에 들지 않습니다", style: TextStyle(fontSize: MSize.kFont.xl)),
          _buildSubInfo(),
          _buildButtons(),
        ],
      ),
    );
  }

  Row _buildSubInfo() {
    return Row(
      spacing: 20,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "신고날짜 : 2015-04-04",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "신고자 : 아이디asfddddddddddddddd",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Row _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: MButton(
            onPressed: () {},
            text: "거절",
            backgroundColor: MColor.kButton.like,
          ),
        ),
        SizedBox(width: MSize.kGap.l),
        Expanded(
          child: MButton(
            onPressed: () {},
            text: "수락",
          ),
        ),
      ],
    );
  }
}
