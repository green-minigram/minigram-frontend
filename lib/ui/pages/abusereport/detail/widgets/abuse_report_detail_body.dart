import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/detail/widgets/report_bottom_sheet.dart';

class AbuseReportDetailBody extends StatelessWidget {
  const AbuseReportDetailBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(child: PostDetailBody()), // 이 부분만 교체하면서 사용
        ReportBottomSheet(),
      ],
    );
  }
}
