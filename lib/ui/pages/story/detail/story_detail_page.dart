import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/detail/widgets/story_detail_body.dart';

class StoryDetailPage extends StatelessWidget {
  const StoryDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryDetailBody(),
    );
  }
}
