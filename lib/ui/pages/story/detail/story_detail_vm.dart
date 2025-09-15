import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/story.dart';
import 'package:minigram/data/model/user.dart';
import 'package:minigram/data/repository/story_repository.dart';

final storyDetailProvider = AutoDisposeNotifierProvider.family<StoryDetailVM, StoryDetailModel?, int>(() {
  return StoryDetailVM();
});

class StoryDetailVM extends AutoDisposeFamilyNotifier<StoryDetailModel?, int> {
  Timer? _likeDebounce; // 좋아요 타이머
  Timer? _followDebounce; // 팔로우 타이머
  @override
  StoryDetailModel? build(int storyId) {
    init(storyId);

    ref.onDispose(() {
      Logger().d("StoryDetailVM 파괴됨");
    });

    return null;
  }

  Future<void> init(int storyId) async {
    final data = await StoryRepository().getOne(storyId);

    if (data["status"] != 200) {
      Logger().e("스토리 조회 실패: ${data["msg"]}");
      return;
    }

    final body = data["body"] as Map<String, dynamic>;
    state = StoryDetailModel.fromMap(body);
  }

  // 팔로우 토글
  Future<void> toggleFollow(int userId) async {
    if (state == null) return;

    final prevState = state!;
    final newIsFollowing = !prevState.isFollowing;

    // 1) UI 먼저 토글
    state = StoryDetailModel(
      user: prevState.user,
      story: prevState.story,
      isFollowing: newIsFollowing,
      isOwner: prevState.isOwner,
      isLiked: prevState.isLiked,
      likeCount: prevState.likeCount,
    );
    Logger().d("팔로우 상태 변경 (UI 반영): $newIsFollowing");

    // 2) 디바운스 → 마지막 액션만 서버로 반영
    _followDebounce?.cancel();
    _followDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        Logger().d("팔로우 통신 시작 (userId=$userId)");
        Map<String, dynamic> data;
        if (newIsFollowing) {
          data = await StoryRepository().follow(userId);
        } else {
          data = await StoryRepository().unfollow(userId);
        }
        Logger().d("팔로우 통신 끝: $data");
      } catch (e) {
        Logger().e("팔로우 통신 오류: $e");
      }
    });
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
