import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/story.dart';
import 'package:minigram/data/model/user.dart';
import 'package:minigram/data/repository/story_repository.dart';

final storyRecentProvider = AutoDisposeNotifierProvider.family<StoryRecentVM, StoryResentModel?, int>(() {
  return StoryRecentVM();
});

class StoryRecentVM extends AutoDisposeFamilyNotifier<StoryResentModel?, int> {
  @override
  StoryResentModel? build(int userId) {
    init(userId);
    return null;
  }

  Future<void> init(int userId) async {
    Logger().d('init 호출');
    final data = await StoryRepository().getRecent(userId);
    Logger().d('StoryRepository 통신 종료 : $data');

    if (data["status"] != 200) return;
    final body = data["body"] as Map<String, dynamic>;
    state = StoryResentModel.fromMap(body);
  }

  // 팔롱 토글
  Timer? _debounce;

  Future<void> toggleFollowDebounced(int userId) async {
    if (state == null) return;

    final prevList = state!.storyList;
    final isFollowing = prevList.first.isFollowing;

    // UI 즉시 반영
    state = StoryResentModel(
      user: state!.user,
      storyList: prevList.map((item) => item.copyWith(isFollowing: !isFollowing)).toList(),
    );

    // 이전 타이머 취소 → 마지막 동작만 남김
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        if (!isFollowing) {
          // 마지막 동작이 팔로우라면 → 등록
          await StoryRepository().follow(userId);
        } else {
          // 마지막 동작이 언팔로우라면 → 취소
          await StoryRepository().unfollow(userId);
        }
      } catch (e) {
        Logger().e("팔로우 통신 실패: $e");
      }
    });
  }
}

class StoryResentModel {
  final User user; // user는 공통 1개로 처리했음
  final List<StoryItem> storyList;

  StoryResentModel({
    required this.user,
    required this.storyList,
  });

  factory StoryResentModel.fromMap(Map<String, dynamic> map) {
    final first = (map["storyList"] as List).first as Map<String, dynamic>;

    return StoryResentModel(
      user: User.fromMap(first["user"]),
      storyList: (map["storyList"] as List<dynamic>).map((e) => StoryItem.fromMap(e)).toList(),
    );
  }
}

class StoryItem {
  final Story story;
  final bool isFollowing;
  final bool isOwner;
  final bool isLiked;
  final int likeCount;

  StoryItem({
    required this.story,
    required this.isFollowing,
    required this.isOwner,
    required this.isLiked,
    required this.likeCount,
  });

  factory StoryItem.fromMap(Map<String, dynamic> map) {
    return StoryItem(
      story: Story.fromMap(map["story"]),
      isFollowing: map["isFollowing"],
      isOwner: map["isOwner"],
      isLiked: map["isLiked"],
      likeCount: map["likeCount"],
    );
  }

  StoryItem copyWith({
    Story? story,
    bool? isFollowing,
    bool? isOwner,
    bool? isLiked,
    int? likeCount,
  }) {
    return StoryItem(
      story: story ?? this.story,
      isFollowing: isFollowing ?? this.isFollowing,
      isOwner: isOwner ?? this.isOwner,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
    );
  }
}
