import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MBottomSheet extends StatelessWidget {
  final List<MBottomSheetItem> items;

  const MBottomSheet({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            margin: EdgeInsets.only(top: MSize.kGap.xs, bottom: MSize.kGap.m),
            decoration: BoxDecoration(
              color: MColor.kNormal.grey400,
              borderRadius: BorderRadius.circular(MSize.kBorderRadius.xxs),
            ),
          ),
          Container(
            margin: EdgeInsets.all(MSize.kGap.m),
            child: Material(
              borderRadius: BorderRadius.circular(MSize.kGap.m),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < items.length; i++) ...[
                    ListTile(
                      tileColor: MColor.kButton.disabled,
                      leading: Icon(items[i].icon, color: items[i].color),
                      title: Text(items[i].text, style: TextStyle(color: items[i].color)),
                      onTap: items[i].onTap,
                    ),
                    if (i != items.length - 1) Divider(height: MSize.kLine.normal),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MBottomSheetItem {
  final String text;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  MBottomSheetItem({
    required this.text,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}
