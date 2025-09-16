import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_theme.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/abusereport/abuse_report_page.dart';
import 'package:minigram/ui/pages/abusereport/complete/report_complete_page.dart';
import 'package:minigram/ui/pages/abusereport/reason/abuse_report_reason_page.dart';
import 'package:minigram/ui/pages/auth/join_page/email_page.dart';
import 'package:minigram/ui/pages/auth/join_page/password_page.dart';
import 'package:minigram/ui/pages/auth/join_page/username_page.dart';
import 'package:minigram/ui/pages/auth/login_page/login_page.dart';
import 'package:minigram/ui/pages/holder/main_holder.dart';
import 'package:minigram/ui/pages/holder/profile/edit/profile_edit_bio_page.dart';
import 'package:minigram/ui/pages/holder/profile/edit/profile_edit_birth_date_page.dart';
import 'package:minigram/ui/pages/holder/profile/edit/profile_edit_gender_page.dart';
import 'package:minigram/ui/pages/holder/profile/edit/profile_edit_name_page.dart';
import 'package:minigram/ui/pages/holder/profile/edit/profile_edit_page.dart';
import 'package:minigram/ui/pages/holder/profile/setting/profile_setting_page.dart';
import 'package:minigram/ui/pages/notification/notification_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MDate.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 한국어 localization 설정
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'), // 한국어
        const Locale('en', 'US'), // 영어
      ],
      locale: const Locale('ko', 'KR'),
      // 기본 언어를 한국어로 설정
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: mTheme(),
      home: const MainHolder(),
      routes: {
        MRoute.mainHolder: (context) => const MainHolder(),
        MRoute.joinEmail: (context) => const EmailPage(),
        MRoute.joinUsername: (context) => const UsernamePage(),
        MRoute.joinPassword: (context) => const PasswordPage(),
        MRoute.login: (context) => const LoginPage(),
        MRoute.profileEdit: (context) => const ProfileEditPage(),
        MRoute.profileEditName: (context) => const ProfileEditNamePage(),
        MRoute.profileEditBio: (context) => const ProfileEditBioPage(),
        MRoute.profileEditBirthDate: (context) =>
            const ProfileEditBirthDatePage(),
        MRoute.profileEditGender: (context) => ProfileEditGenderPage(),
        MRoute.profileSetting: (context) => ProfileSettingPage(),
        // MRoute.follower: (context) => const FollowPage(),
        // MRoute.following: (context) => const FollowPage(),
        MRoute.abuseReport: (context) => const AbuseReportPage(),
        MRoute.reportComplete: (context) => ReportCompletePage(),
        MRoute.notification: (context) => const NotificationPage(),
        MRoute.reportReason: (context) => AbuseReportReasonPage(),
      },
    );
  }
}
