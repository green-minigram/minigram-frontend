import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/detail/widgets/abuse_report_detail_body.dart';

class AbuseReportDetailPage extends StatelessWidget {
  int reportId;

  AbuseReportDetailPage({required this.reportId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: AbuseReportDetailBody(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: const Text("신고 상세"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
