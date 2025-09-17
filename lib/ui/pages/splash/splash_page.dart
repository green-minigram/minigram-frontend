import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:minigram/m_route.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void _initAsync(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, MRoute.login);
  }

  static const List<Color> _igColors = <Color>[
    Color(0xFFDD2A7B),
    Color(0xFF8134AF),
    Color(0xFF515BD4),
    Color(0xFF8134AF),
    Color(0xFFDD2A7B),
    Color(0xFFFEDA77),
    Color(0xFFF58529),
  ];

  static const TextStyle _colorizeTextStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    _initAsync(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo/instagram_logo_2022.webp",
              width: 100,
              height: 100,
            ),

            const SizedBox(height: 24),

            AnimatedTextKit(
              isRepeatingAnimation: true,
              repeatForever: true,
              pause: Duration.zero,
              animatedTexts: [
                ColorizeAnimatedText(
                  'Minigram',
                  textStyle: _colorizeTextStyle,
                  colors: _igColors,
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 1000),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
