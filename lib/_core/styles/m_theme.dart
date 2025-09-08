import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

ThemeData mTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: MColor.kPrimary.normal,
    scaffoldBackgroundColor: MColor.kNormal.white,
    appBarTheme: AppBarTheme(
      backgroundColor: MColor.kNormal.white,
      titleTextStyle: TextStyle(fontSize: MSize.kFont.xl, fontWeight: FontWeight.w700, color: MColor.kText.title),
      centerTitle: true,
      elevation: 0,
    ),
    dividerTheme: DividerThemeData(
      thickness: MSize.kLine.normal,
      color: MColor.kLine.main,
    ),
    textTheme: GoogleFonts.notoSansTextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: MColor.kPrimary.strong,
      unselectedItemColor: MColor.kText.normal,
      selectedLabelStyle: TextStyle(fontSize: MSize.kFont.s, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(fontSize: MSize.kFont.s, fontWeight: FontWeight.w400),
    ),
    // inputDecorationTheme: InputDecorationTheme(
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(8),
    //     borderSide: BorderSide(color: MColor.kLine.main),
    //   ),
    //   contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //   hintStyle: TextStyle(fontSize: MSize.kFont.normal, color: MColor.kText.normal),
    // ),
  );
}
