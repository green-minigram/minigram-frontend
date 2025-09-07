import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ProfileEditBirthDateBody extends StatelessWidget {
  const ProfileEditBirthDateBody({
    super.key,
  });

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 360,
        color: MColor.kBackGround.normal,
        child: SafeArea(
          child: CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            showDayOfWeek: false,
            maximumDate: DateTime.now(),
            dateOrder: DatePickerDateOrder.ymd,
            onDateTimeChanged: (DateTime newDate) {
              // 나중에 리버팟으로 상태관리 할 예정
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MSize.kGap.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => _showDatePicker(context),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: MSize.kGap.xs, horizontal: MSize.kGap.l),
              decoration: BoxDecoration(
                border: Border.all(color: MColor.kLine.gray),
                borderRadius: BorderRadius.circular(MSize.kBorderRadius.l),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '생일',
                        style: TextStyle(
                          fontSize: MSize.kFont.normal,
                          color: MColor.kText.secondary,
                        ),
                      ),
                      SizedBox(height: MSize.kGap.xxs),
                      Text(
                        '2025년 09월 07일', // 하드코딩된 예시 데이터
                        style: TextStyle(
                          fontSize: MSize.kFont.m,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      // 나중에 리버팟으로 날짜 초기화 기능 구현
                    },
                    icon: Icon(
                      Icons.close,
                      color: MColor.kText.secondary,
                      size: MSize.kFont.xxl,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
