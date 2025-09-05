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
                    contentPadding: EdgeInsets.all(0),
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
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    suffix: IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 5,
        ),
      ],
    );
  }
}
