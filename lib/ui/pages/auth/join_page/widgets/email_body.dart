import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/auth/join_page/widgets/email_form.dart';
import 'package:minigram/ui/pages/auth/join_page/widgets/join_page_indicator.dart';

class EmailBody extends StatelessWidget {
  int pageNum = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      child: Column(
        children: [
          JoinPageIndicator(pageNum: pageNum),
          Flexible(
            child: EmailForm(),
          ),
        ],
      ),
    );
  }
}
