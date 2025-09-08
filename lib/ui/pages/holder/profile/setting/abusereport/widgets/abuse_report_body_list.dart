import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/holder/profile/setting/abusereport/widgets/report_list_item.dart';

final List<Map<String, String>> reports = [
  {
    "type": "게시글dsfasfasfdasfdasdfasdfasdf",
    "reporterId": "user02221asdfasfsdafsdf",
    "date": "2015-07-01",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/1/50",
  },
  {
    "type": "댓글",
    "reporterId": "user02",
    "date": "2016-05-15",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/2/50",
  },
  {
    "type": "메시지",
    "reporterId": "user03",
    "date": "2017-11-23",
    "status": "거절됨",
    "profileImageUrl": "https://picsum.photos/seed/3/50",
  },
  {
    "type": "게시글",
    "reporterId": "user04",
    "date": "2018-01-30",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/4/50",
  },
  {
    "type": "댓글",
    "reporterId": "user05",
    "date": "2019-09-12",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/5/50",
  },
  {
    "type": "게시글",
    "reporterId": "user01",
    "date": "2015-07-01",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/1/50",
  },
  {
    "type": "댓글",
    "reporterId": "user02",
    "date": "2016-05-15",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/2/50",
  },
  {
    "type": "메시지",
    "reporterId": "user03",
    "date": "2017-11-23",
    "status": "거절됨",
    "profileImageUrl": "https://picsum.photos/seed/3/50",
  },
  {
    "type": "게시글",
    "reporterId": "user04",
    "date": "2018-01-30",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/4/50",
  },
  {
    "type": "댓글",
    "reporterId": "user05",
    "date": "2019-09-12",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/5/50",
  },
  {
    "type": "게시글",
    "reporterId": "user01",
    "date": "2015-07-01",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/1/50",
  },
  {
    "type": "댓글",
    "reporterId": "user02",
    "date": "2016-05-15",
    "status": "수락됨",
    "profileImageUrl": "https://picsum.photos/seed/2/50",
  },
  {
    "type": "메시지",
    "reporterId": "user03",
    "date": "2017-11-23",
    "status": "거절됨",
    "profileImageUrl": "https://picsum.photos/seed/3/50",
  },
  {
    "type": "게시글",
    "reporterId": "user04",
    "date": "2018-01-30",
    "status": "대기중",
    "profileImageUrl": "https://picsum.photos/seed/4/50",
  },
  {
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
            onTap: () {},
          );
        },
        childCount: reports.length,
      ),
    );
  }
}
