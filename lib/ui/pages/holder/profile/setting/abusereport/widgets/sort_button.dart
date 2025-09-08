import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

const List<String> list = <String>["오래된순", "최신순"];

class SortButton extends StatelessWidget {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.m),
      dropdownColor: MColor.kBackGround.normal,
      elevation: 1,
      borderRadius: BorderRadius.circular(MSize.kGap.xs),
      underline: Container(),
      value: dropdownValue,
      style: const TextStyle(color: Colors.black),
      onChanged: (String? value) {
        // This is called when the user selects an item.
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
    );
  }
}
