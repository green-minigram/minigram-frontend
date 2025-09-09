import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/abusereport/detail/abuse_report_detail_page.dart';
import 'package:minigram/ui/pages/abusereport/widgets/report_list_item.dart';

final List<Map<String, String>> reports = [
  {
    "reportId": "1",
    "type": "게시글dsfasfasfdasfdasdfasdfasdf",
    "reporterId": "user02221asdfasfsdafsdf",
    "date": "2015-07-01",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/1/50",
  },
  {
    "reportId": "2",
    "type": "댓글",
    "reporterId": "user02",
    "date": "2016-05-15",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/2/50",
  },
  {
    "reportId": "3",
    "type": "메시지",
    "reporterId": "user03",
    "date": "2017-11-23",
    "status": "거절됨",
    "profileImageUrl": "https://picsum.photos/seed/3/50",
  },
  {
    "reportId": "4",
    "type": "게시글",
    "reporterId": "user04",
    "date": "2018-01-30",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/4/50",
  },
  {
    "reportId": "5",
    "type": "댓글",
    "reporterId": "user05",
    "date": "2019-09-12",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/5/50",
  },
  {
    "reportId": "6",
    "type": "게시글",
    "reporterId": "user01",
    "date": "2015-07-01",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/1/50",
  },
  {
    "reportId": "7",
    "type": "댓글",
    "reporterId": "user02",
    "date": "2016-05-15",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/2/50",
  },
  {
    "reportId": "8",
    "type": "메시지",
    "reporterId": "user03",
    "date": "2017-11-23",
    "status": "거절됨",
    "profileImageUrl": "https://picsum.photos/seed/3/50",
  },
  {
    "reportId": "9",
    "type": "게시글",
    "reporterId": "user04",
    "date": "2018-01-30",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/4/50",
  },
  {
    "reportId": "10",
    "type": "댓글",
    "reporterId": "user05",
    "date": "2019-09-12",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/5/50",
  },
  {
    "reportId": "11",
    "type": "게시글",
    "reporterId": "user01",
    "date": "2015-07-01",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/1/50",
  },
  {
    "reportId": "12",
    "type": "댓글",
    "reporterId": "user02",
    "date": "2016-05-15",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/2/50",
  },
  {
    "reportId": "13",
    "type": "메시지",
    "reporterId": "user03",
    "date": "2017-11-23",
    "status": "거절됨",
    "profileImageUrl": "https://picsum.photos/seed/3/50",
  },
  {
    "reportId": "14",
    "type": "게시글",
    "reporterId": "user04",
    "date": "2018-01-30",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/4/50",
  },
  {
    "reportId": "15",
    "type": "댓글",
    "reporterId": "user05",
    "date": "2019-09-12",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/5/50",
  },
];

class AbuseReportBodyList extends StatelessWidget {
  const AbuseReportBodyList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final report = reports[index];
          return ReportListItem(
            reportType: report["type"]!,
            reporterId: report["reporterId"]!,
            reportDate: report["date"]!,
            status: report["status"]!,
            profileImageUrl: report["profileImageUrl"]!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AbuseReportDetailPage(
                    reportId: 1,
                  ),
                ),
              );
            },
          );
        },
        childCount: reports.length,
      ),
    );
  }
}
