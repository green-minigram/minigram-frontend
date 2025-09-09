import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class ReportListItem extends StatelessWidget {
  final String reportType;
  final String reporterId;
  final String reportDate;
  final String status;
  final String? profileImageUrl;
  final VoidCallback onTap;

  const ReportListItem({
    super.key,
    required this.reportType,
    required this.reporterId,
    required this.reportDate,
    required this.status,
    this.profileImageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l, vertical: MSize.kGap.s),
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
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      reportType,
                      style: TextStyle(fontSize: MSize.kFont.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      reporterId,
                      style: TextStyle(fontSize: MSize.kFont.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      reportDate,
                      style: TextStyle(fontSize: MSize.kFont.normal),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontSize: MSize.kFont.s,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case '대기중':
        return Colors.orange;
      case '수락됨':
        return Colors.green;
      case '거절됨':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
