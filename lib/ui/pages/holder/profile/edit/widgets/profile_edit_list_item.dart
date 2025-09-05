import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileEditListItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? trailingUrl;

  const ProfileEditListItem({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailingUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.xl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // title 부분 (너비를 고정하여 subtitle 시작점 일정하게 유지)
          Padding(
            padding: EdgeInsets.only(right: MSize.kGap.huge),
            child: SizedBox(
              width: MSize.kGap.doubleHuge, // title 텍스트가 들어갈 공간의 너비 고정 (적절한 값으로 조절)
              child: Text(
                title,
                style: TextStyle(fontSize: MSize.kFont.l),
              ),
            ),
          ),

          // subtitle 부분
          Expanded(
            child: Text(
              subtitle,
              style: TextStyle(fontSize: MSize.kFont.l),
              textAlign: TextAlign.start,
            ),
          ),

          // trailing (수정) 버튼
          if (trailingUrl != null)
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, trailingUrl!);
              },
              icon: Icon(Icons.edit, size: MSize.kIcon.m),
            ),
        ],
      ),
    );
  }
}
