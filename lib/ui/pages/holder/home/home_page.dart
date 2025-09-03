import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/home/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    print('홈 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: _appBar(context),
      body: HomeBody(),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leadingWidth: 150,
    leading: Padding(
      padding: EdgeInsets.only(left: MSizes.kGap.sm),
      child: Text(
        "minigram",
        style: GoogleFonts.lobsterTwo(
          fontSize: MSizes.kFont.xxxl,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Colors.black,
          size: MSizes.kIcon.l,
        ),
        onPressed: () {},
      ),
    ],
  );
}
