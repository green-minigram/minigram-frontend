import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/complete/widgets/report_complete_body.dart';

class ReportCompletePage extends StatelessWidget {
  ReportCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("신고하기"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
              // Navigator.pop(context); TODO pop 2번?
            },
          ),
        ],
      ),
      body: ReportCompleteBody(),
    );
  }
}
