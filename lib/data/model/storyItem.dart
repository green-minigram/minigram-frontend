import 'package:minigram/data/model/story.dart';
import 'package:minigram/data/model/user.dart';

class StoryItem {
  final User user;
  final List<Story> story;
  final isNew;

  StoryItem({
    required this.user,
    required this.story,
  });

  StoryItem.fromMap(Map<String, dynamic> data) : user = data['userId'], story = data['username'];
}
