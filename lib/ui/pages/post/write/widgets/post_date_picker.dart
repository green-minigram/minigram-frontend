import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class PostDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDate;
  final void Function(DateTime?) onDateChanged;

  const PostDatePicker({
    super.key,
    required this.label,
    required this.selectedDate,
    required this.onDateChanged,
  });

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 360,
        color: MColor.kBackGround.normal,
        child: SafeArea(
          child: CupertinoDatePicker(
            initialDateTime: selectedDate ?? DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            maximumDate: DateTime(2100),
            dateOrder: DatePickerDateOrder.ymd,
            onDateTimeChanged: (DateTime newDate) {
              onDateChanged(newDate);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDatePicker(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: MSize.kGap.xs,
          horizontal: MSize.kGap.l,
        ),
        margin: EdgeInsets.symmetric(horizontal: MSize.kGap.m, vertical: MSize.kGap.s),
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
                  label,
                  style: TextStyle(
                    fontSize: MSize.kFont.normal,
                    color: MColor.kText.secondary,
                  ),
                ),
                SizedBox(height: MSize.kGap.xxs),
                Text(
                  selectedDate != null
                      ? "${selectedDate!.year}년 ${selectedDate!.month}월 ${selectedDate!.day}일"
                      : "날짜를 선택하세요",
                  style: TextStyle(
                    fontSize: MSize.kFont.m,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            if (selectedDate != null)
              IconButton(
                onPressed: () => onDateChanged(null),
                icon: Icon(
                  Icons.close,
                  color: MColor.kText.secondary,
                  size: MSize.kFont.xxl,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
