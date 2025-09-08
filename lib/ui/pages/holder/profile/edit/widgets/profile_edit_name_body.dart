import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileEditNameBody extends StatelessWidget {
  const ProfileEditNameBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MSize.kGap.l),
      child: Container(
        padding: EdgeInsets.only(left: MSize.kGap.xl),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(MSize.kBorderRadius.l),
        ),
        child: TextField(
          cursorColor: MColor.kText.normal,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
            labelText: '이름',
            labelStyle: TextStyle(color: MColor.kText.normal),
          ),
        ),
      ),
    );
  }
}
