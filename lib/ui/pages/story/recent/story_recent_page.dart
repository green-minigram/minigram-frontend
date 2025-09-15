import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/recent/widgets/story_recent_body.dart';

class StoryRecentPage extends StatelessWidget {
  final int userId;

  const StoryRecentPage({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryRecentBody(userId: userId),
    );
  }
}
