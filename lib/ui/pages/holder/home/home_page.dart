import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/holder/home/widgets/home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeBody(),
    );
  }
}
