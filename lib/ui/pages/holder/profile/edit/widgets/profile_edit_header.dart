import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileEditHeader extends StatelessWidget {
  const ProfileEditHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MSize.kGap.m),
      child: Column(
        spacing: MSize.kGap.m,
        children: [
          Material(
            // Material 위젯에 원형 모양과 배경색을 지정합니다.
            shape: CircleBorder(
              side: BorderSide(
                // ✅ 여기에 테두리 속성을 추가
                color: MColor.kLine.main, // 테두리 색상
              ),
            ),
            color: MColor.kBackGround.gray,
            child: InkWell(
              // InkWell의 splash 효과가 원형이 되도록 border radius를 지정합니다.
              borderRadius: BorderRadius.circular(35),
              onTap: () {
                print('프로필 아바타 클릭!');
              },
              child: CircleAvatar(
                // CircleAvatar는 배경색 없이 아이콘만 표시하도록 변경
                radius: 35,
                backgroundColor: Colors.transparent, // 투명하게 설정
                child: Icon(
                  Icons.person,
                  color: MColor.kBackGround.darkGray,
                  size: 70,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "사진 또는 아바타 수정",
              style: TextStyle(
                color: MColor.kText.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
