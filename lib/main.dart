import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';

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
      home: PostDetailPage(),
      routes: {
        "/main-holder": (context) => Placeholder(),
        "/login": (context) => Placeholder(),
      },
    );
  }
}
