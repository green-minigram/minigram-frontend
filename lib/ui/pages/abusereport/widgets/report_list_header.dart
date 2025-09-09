import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ReportListHeader extends StatelessWidget {
  const ReportListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l, vertical: MSize.kGap.m),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: MColor.kLine.main, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '신고 유형',
                      style: TextStyle(
                        fontSize: MSize.kFont.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '신고자 아이디',
                      style: TextStyle(
                        fontSize: MSize.kFont.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '신고 날짜',
                      style: TextStyle(
                        fontSize: MSize.kFont.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '처리 상태',
                      style: TextStyle(
                        fontSize: MSize.kFont.normal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
