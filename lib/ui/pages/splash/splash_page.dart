import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/m_route.dart';

class SplashPage extends ConsumerWidget {
  const SplashPage();

  void _initAsync(BuildContext context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, MRoute.login);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _initAsync(context);

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/splash/splash.gif",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
