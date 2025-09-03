import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/join/form_email_page.dart';
import 'package:minigram/ui/pages/join/form_password_page.dart';
import 'package:minigram/ui/pages/join/form_username_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: null,
      home: FormEmailPage(),
      routes: {
        "/main-holder": (context) => Placeholder(),
        "/join/form-username": (context) => FormUsernamePage(),
        "/join/form-password": (context) => FormPasswordPage(),
      },
    );
  }
}
