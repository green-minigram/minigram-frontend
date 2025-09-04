import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/holder/search/widgets/search_body.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SearchBody()),
    );
  }
}
