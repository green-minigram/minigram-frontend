import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/reason/widgets/abuse_report_reason_body.dart';

class AbuseReportReasonPage extends StatelessWidget {
  AbuseReportReasonPage({super.key});

  // 더미 데이터
  final List<Map<String, dynamic>> reportReasons = [
    {"reasonId": 1, "reason": "마음에 들지 않습니다"},
    {"reasonId": 2, "reason": "따돌림 또는 원치 않는 연락"},
    {"reasonId": 3, "reason": "자살, 자해 및 섭식 장애"},
    {"reasonId": 4, "reason": "폭력, 혐오 또는 학대"},
    {"reasonId": 5, "reason": "규제 품목을 판매하거나 홍보함"},
    {"reasonId": 6, "reason": "나체 이미지 또는 성적 행위"},
    {"reasonId": 7, "reason": "스팸, 사기 또는 스팸"},
    {"reasonId": 8, "reason": "거짓 정보"},
    {"reasonId": 9, "reason": "지식재산권 침해"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: AbuseReportReasonBody(reportReasons: reportReasons),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios),
      ),
      title: Text("신고하기"),
      centerTitle: true,
    );
  }
}
