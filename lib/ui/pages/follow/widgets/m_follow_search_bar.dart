import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MFollowSearchBar extends StatelessWidget {
  const MFollowSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: MSize.kGap.l,
            left: MSize.kGap.l,
            right: MSize.kGap.l,
            bottom: MSize.kGap.xxxxs,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(fontSize: MSize.kFont.l, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: MSize.kGap.s),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(MSize.kBorderRadius.m),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: MColor.kLine.subtle,
                    hintText: '검색',
                    hintStyle: TextStyle(
                      fontSize: MSize.kFont.l,
                      fontWeight: FontWeight.bold,
                      color: MColor.kText.secondary,
                    ),
                    prefixIcon: Icon(Icons.search, size: 20),
                    prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
                    suffixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
                    suffixIcon: IconButton(
                      onPressed: () {
                        print('x 버튼 클릭됨');
                      },
                      icon: Icon(Icons.clear, size: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
