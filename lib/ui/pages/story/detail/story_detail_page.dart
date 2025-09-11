import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/detail/widgets/story_detail_body.dart';

class StoryDetailPage extends StatelessWidget {
  final int storyId;

  const StoryDetailPage({super.key, required this.storyId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryDetailBody(storyId: storyId),
    );
  }
}
