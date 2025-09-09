import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/widgets/abuse_report_body.dart';

class AbuseReportPage extends StatelessWidget {
  const AbuseReportPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: AbuseReportBody(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      title: const Text("신고 내역"),
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
    );
  }
}
