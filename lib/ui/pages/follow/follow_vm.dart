import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/repository/follow_repository.dart';

// 팔로워 Provider
final followerProvider =
    AutoDisposeNotifierProvider.family<FollowerVM, List<FollowUser>?, int>(() {
      return FollowerVM();
    });

// 팔로잉 Provider
final followingProvider =
    AutoDisposeNotifierProvider.family<FollowingVM, List<FollowUser>?, int>(() {
      return FollowingVM();
    });

class FollowerVM extends AutoDisposeFamilyNotifier<List<FollowUser>?, int> {
  @override
  List<FollowUser>? build(int userId) {
    init(userId);
    return null;
  }

  Future<void> init(int userId) async {
    final data = await FollowRepository().getFollowers(userId);

    if (data["status"] != 200) {
      Logger().e("팔로워 조회 실패: ${data["msg"]}");
      return;
    }

    final list = (data["body"]["userList"] as List)
        .map((e) => FollowUser.fromMap(e))
        .toList();

    state = list;
  }
}

class FollowingVM extends AutoDisposeFamilyNotifier<List<FollowUser>?, int> {
  @override
  List<FollowUser>? build(int userId) {
    init(userId);
    return null;
  }

  Future<void> init(int userId) async {
    final data = await FollowRepository().getFollowing(userId);

    if (data["status"] != 200) {
      Logger().e("팔로잉 조회 실패: ${data["msg"]}");
      return;
    }

    final list = (data["body"]["userList"] as List)
        .map((e) => FollowUser.fromMap(e))
        .toList();

    state = list;
  }
}

class FollowUser {
  final int userId;
  final String username;
  final String name;
  final String? profileImageUrl;
  final bool isFollowing;
  final bool isMe;

  FollowUser({
    required this.userId,
    required this.username,
    required this.name,
    this.profileImageUrl,
    required this.isFollowing,
    required this.isMe,
  });

  factory FollowUser.fromMap(Map<String, dynamic> map) {
    return FollowUser(
      userId: map["userId"],
      username: map["username"],
      name: map["name"],
      profileImageUrl: map["profileImageUrl"],
      isFollowing: map["isFollowing"],
      isMe: map["isMe"],
    );
  }
}
