import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileHeaderInfoRow extends StatelessWidget {
  const ProfileHeaderInfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: MSize.kGap.huge,
      children: [
        _buildInkWell(count: 1, text: "게시물"),
        _buildInkWell(count: 5, text: "팔로우"),
        _buildInkWell(count: 9, text: "팔로잉"),
      ],
    );
  }

  InkWell _buildInkWell({required int count, required String text, String url = ""}) {
    return InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString(),
            style: TextStyle(fontSize: MSize.kFont.xl, fontWeight: FontWeight.bold),
          ),
          Text(
            text,
            style: TextStyle(fontSize: MSize.kFont.l, fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
