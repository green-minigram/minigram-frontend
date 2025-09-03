import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_theme.dart';
import 'package:minigram/ui/pages/holder/main_holder.dart';

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
      theme: mTheme(),
      home: MainHolder(),
      routes: {
        "/main-holder": (context) => Placeholder(),
        "/login": (context) => Placeholder(),
      },
    );
  }
}
