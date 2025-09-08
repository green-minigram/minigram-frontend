import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';

class ProfileEditHeader extends StatelessWidget {
  const ProfileEditHeader({
    super.key,
  });

  void onImageEditTap(BuildContext context) {
    MBottomSheet.show(
      context,
      items: [
        MSheetItem(text: "라이브러리에서 선택", icon: Icons.image_outlined, color: Colors.black, onTap: () {}),
        MSheetItem(text: "현재 사진 삭제", icon: Icons.delete_outline, color: Colors.red, onTap: () {}),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MSize.kGap.m),
      child: Column(
        spacing: MSize.kGap.m,
        children: [
          Material(
            shape: CircleBorder(
              side: BorderSide(
                color: MColor.kLine.main,
              ),
            ),
            color: MColor.kBackGround.gray,
            child: InkWell(
              borderRadius: BorderRadius.circular(35),
              onTap: () => onImageEditTap(context),
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.person,
                  color: MColor.kBackGround.darkGray,
                  size: 70,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => onImageEditTap(context),
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
