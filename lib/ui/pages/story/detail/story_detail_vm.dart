import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/story.dart';
import 'package:minigram/data/model/user.dart';
import 'package:minigram/data/repository/story_repository.dart';

final storyDetailProvider = AutoDisposeNotifierProvider.family<StoryDetailVM, StoryDetailModel?, int>(() {
  return StoryDetailVM();
});

class StoryDetailVM extends AutoDisposeFamilyNotifier<StoryDetailModel?, int> {
  @override
  StoryDetailModel? build(int storyId) {
    init(storyId);

    ref.onDispose(() {
      Logger().d("StoryDetailVM 파괴됨");
    });

    return null;
  }

  Future<void> init(int storyId) async {
    Logger().d("init 시작");
    final data = await StoryRepository().getOne(storyId);
    Logger().d("data 반환 : $data");

    if (data["status"] != 200) {
      Logger().e("스토리 조회 실패: ${data["msg"]}");
      return;
    }

    final body = data["body"] as Map<String, dynamic>;
    state = StoryDetailModel.fromMap(body);
    Logger().d("fromMap 성공 : $state");
  }

  // 삭제
  Future<void> deleteStory(int storyId) async {
    final data = await StoryRepository().delete(storyId);
    if (data["status"] == 200) {
      // 삭제 성공 시 상태 null로 바꿔서 UI에서 스토리 사라지도록
      state = null;
      Logger().d("스토리 삭제 성공: $data");
    } else {
      Logger().e("스토리 삭제 실패: ${data["msg"]}");
    }
  }
}

class StoryDetailModel {
  final User user;
  final Story story;
  final bool isFollowing;
  final bool isOwner;
  final bool isLiked;
  final int likeCount;

  StoryDetailModel({
    required this.user,
    required this.story,
    required this.isFollowing,
    required this.isOwner,
    required this.isLiked,
    required this.likeCount,
  });

  factory StoryDetailModel.fromMap(Map<String, dynamic> map) {
    return StoryDetailModel(
      user: User.fromMap(map["user"]),
      story: Story.fromMap(map["story"]),
      isFollowing: map["isFollowing"],
      isOwner: map["isOwner"],
      isLiked: map["isLiked"],
      likeCount: map["likeCount"],
    );
  }
}
