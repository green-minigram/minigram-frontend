import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MFollowSearchBar extends StatelessWidget {
  final void Function(String value)? onChanged;
  final VoidCallback? onClear;
  final bool showClearButton;
  final TextEditingController controller;

  const MFollowSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.showClearButton = false,
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
                  controller: controller,
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
                    suffixIcon: showClearButton
                        ? IconButton(
                            onPressed: onClear,
                            icon: Icon(Icons.clear, size: 20),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
