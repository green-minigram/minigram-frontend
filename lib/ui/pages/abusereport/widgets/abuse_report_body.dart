import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/widgets/abuse_report_body_header.dart';
import 'package:minigram/ui/pages/abusereport/widgets/abuse_report_body_list.dart';

class AbuseReportBody extends StatelessWidget {
  const AbuseReportBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        AbuseReportBodyHeader(),
        AbuseReportBodyList(),
      ],
    );
  }
}
