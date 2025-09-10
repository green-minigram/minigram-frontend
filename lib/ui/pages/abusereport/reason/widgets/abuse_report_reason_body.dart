import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';

class AbuseReportReasonBody extends StatelessWidget {
  const AbuseReportReasonBody({
    super.key,
    required this.reportReasons,
  });

  final List<Map<String, dynamic>> reportReasons;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(MSize.kGap.l),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "이 게시물을 신고하는 이유",
                style: TextStyle(
                  fontSize: MSize.kFont.xl, // 제목 크기
                  fontWeight: FontWeight.bold,
                  color: MColor.kText.title,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MSize.kFont.xs),
              Text(
                "회원님의 신고는 익명으로 처리됩니다. 누군가 위급한 상황에 있다고 생각된다면 즉시 현지 응급 서비스 기관에 연락하시기 바랍니다.",
                style: TextStyle(
                  fontSize: MSize.kFont.normal, // 설명 크기
                  color: MColor.kText.description,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        Divider(height: MSize.kLine.normal),
        Expanded(
          child: ListView.builder(
            itemCount: reportReasons.length,
            itemBuilder: (context, index) {
              final item = reportReasons[index];
              return ListTile(
                title: Text(item["reason"]),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  // TODO: 신고 사유 선택 시 신고 글 id/신고 이유 전송
                  Navigator.pushNamed(context, MRoute.reportComplete);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
