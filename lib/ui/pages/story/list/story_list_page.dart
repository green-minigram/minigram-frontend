import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/list/widgets/story_list_body.dart';

class StoryListPage extends StatelessWidget {
  const StoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryListBody(),
    );
  }
}
