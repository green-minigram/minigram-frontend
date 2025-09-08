import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class AddBody extends StatelessWidget {
  const AddBody({super.key});

  Widget _buildOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MSize.kBorderRadius.l),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: MSize.kGap.huge),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          border: Border.all(color: color.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(MSize.kBorderRadius.l),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: MSize.kIcon.xl, color: color),
            SizedBox(height: MSize.kGap.s),
            Text(
              label,
              style: TextStyle(
                fontSize: MSize.kFont.l,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MSize.kGap.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildOption(
            icon: Icons.photo_library,
            label: "게시글 등록하기",
            color: MColor.kPrimary.normal,
            onTap: () {
              print("게시글 등록 선택");
            },
          ),
          SizedBox(height: MSize.kGap.huge),
          _buildOption(
            icon: Icons.play_circle_fill,
            label: "스토리 등록하기",
            color: Colors.blue,
            onTap: () {
              print("스토리 등록 선택");
            },
          ),
        ],
      ),
    );
  }
}
