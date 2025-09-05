import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';

class MBottomSheet {
  static void show(
    BuildContext context, {
    required List<MSheetItem> items,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: MColor.kBackGround.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(MSize.kBorderRadius.xl),
        ),
      ),
      builder: (_) => MBottomSheetItem(items: items),
    );
  }
}
