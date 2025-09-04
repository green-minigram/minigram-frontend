import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_theme.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/m_route.dart';
import 'package:minigram/ui/pages/holder/main_holder.dart';
import 'package:minigram/ui/pages/join/email_page.dart';
import 'package:minigram/ui/pages/join/password_page.dart';
import 'package:minigram/ui/pages/join/username_page.dart';
import 'package:minigram/ui/pages/login/login_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MDate.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: mTheme(),
      home: MainHolder(),
      routes: {
        "${MRoute.mainHolder}": (context) => const MainHolder(),
        "${MRoute.joinEmail}": (context) => const EmailPage(),
        "${MRoute.joinUsername}": (context) => const UsernamePage(),
        "${MRoute.joinPassword}": (context) => const PasswordPage(),
        "${MRoute.login}": (context) => const LoginPage(),
      },
    );
  }
}
