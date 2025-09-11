import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/home/widgets/home_body.dart';
import 'package:minigram/ui/pages/notification/notification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: const HomeBody(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, MRoute.notification);
        },
        child: const Icon(Icons.open_in_new),
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    elevation: 0,
    surfaceTintColor: Colors.transparent,
    leadingWidth: 150,
    leading: Padding(
      padding: EdgeInsets.only(left: MSize.kGap.m),
      child: Text(
        "minigram",
        style: GoogleFonts.lobsterTwo(
          fontSize: MSize.kFont.xxxl,
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
          size: MSize.kIcon.l,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationPage(),
            ),
          );
        },
      ),
    ],
  );
}
