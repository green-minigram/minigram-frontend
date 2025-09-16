import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/repository/user_repository.dart';
import 'package:minigram/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 1. 창고 관리자
final profileProvider =
    AutoDisposeNotifierProviderFamily<ProfileVM, ProfileModel?, int>(
      () {
        return ProfileVM();
      },
    );

/// 2. 창고
class ProfileVM extends AutoDisposeFamilyNotifier<ProfileModel?, int> {
  final mContext = navigatorKey.currentContext!;
  final postScrollController = RefreshController();
  final storyScrollController = RefreshController();

  @override
  ProfileModel? build(int userId) {
    init(userId: userId);

    ref.onDispose(() {
      postScrollController.dispose();
      storyScrollController.dispose();
      Logger().d("ProfileVM 파괴됨");
    });

    return null;
  }

  Future<void> init({required int userId}) async {
    /// 프로필 정보 조회
    Map<String, dynamic> profileBody = await UserRepository().getUserProfile(
      userId,
    );
    if (profileBody["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("프로필 조회 실패 : ${profileBody["msg"]}")),
      );
      return;
    }

    state = ProfileModel.fromMap(profileBody["body"]);

    postScrollController.refreshCompleted();
    storyScrollController.refreshCompleted();
  }

  Future<void> nextPostList({required int userId}) async {
    final prevModel = state;
    if (prevModel == null) {
      postScrollController.loadComplete();
      return;
    }

    if (prevModel.postListObject.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      postScrollController.loadComplete();
      return;
    }

    Map<String, dynamic> body = await UserRepository().getUserProfilePostList(
      page: prevModel.postListObject.next,
      userId: userId,
    );
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("유저 프로필 게시글 로딩 실패 : ${body["msg"]}")),
      );
      postScrollController.loadComplete();
      return;
    }

    _PostListObject nextPostObject = _PostListObject.fromMap(body['body']);

    state = prevModel.copyWith(
      postList: prevModel.postListObject.copyWith(
        current: nextPostObject.current,
        size: nextPostObject.size,
        totalCount: nextPostObject.totalCount,
        totalPage: nextPostObject.totalPage,
        prev: nextPostObject.prev,
        next: nextPostObject.next,
        isFirst: nextPostObject.isFirst,
        isLast: nextPostObject.isLast,
        postList: [
          ...prevModel.postListObject.postList,
          ...nextPostObject.postList,
        ],
      ),
    );
    postScrollController.loadComplete();
  }

  Future<void> nextStoryList({required int userId}) async {
    final prevModel = state;
    if (prevModel == null) {
      storyScrollController.loadComplete();
      return;
    }

    if (prevModel.storyListObject.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      storyScrollController.loadComplete();
      return;
    }

    Map<String, dynamic> body = await UserRepository().getUserProfileStoryList(
      userId: userId,
      page: prevModel.storyListObject.next,
    );
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("유저 프로필필 스토리 로딩 실패 : ${body["msg"]}")),
      );
      storyScrollController.loadComplete();
      return;
    }

    _StoryListObject nextStoryObject = _StoryListObject.fromMap(body['body']);

    state = prevModel.copyWith(
      storyList: prevModel.storyListObject.copyWith(
        current: nextStoryObject.current,
        size: nextStoryObject.size,
        totalCount: nextStoryObject.totalCount,
        totalPage: nextStoryObject.totalPage,
        prev: nextStoryObject.prev,
        next: nextStoryObject.next,
        isFirst: nextStoryObject.isFirst,
        isLast: nextStoryObject.isLast,
        storyList: [
          ...prevModel.storyListObject.storyList,
          ...nextStoryObject.storyList,
        ],
      ),
    );
    storyScrollController.loadComplete();
  }
}

/// 3. 창고 데이터 타입
class ProfileModel {
  final _Profile profile;
  final _PostListObject postListObject;
  final _StoryListObject storyListObject;

  ProfileModel({
    required this.profile,
    required this.postListObject,
    required this.storyListObject,
  });

  ProfileModel.fromMap(Map<String, dynamic> data)
    : profile = _Profile.fromMap(data['profile']),
      postListObject = _PostListObject.fromMap(data['postList']),
      storyListObject = _StoryListObject.fromMap(data['storyList']);

  ProfileModel copyWith({
    _Profile? profile,
    _PostListObject? postList,
    _StoryListObject? storyList,
  }) {
    return ProfileModel(
      profile: profile ?? this.profile,
      postListObject: postList ?? this.postListObject,
      storyListObject: storyList ?? this.storyListObject,
    );
  }
}

class _Profile {
  final int userId;
  final String username;
  final String? name;
  final String? bio;
  final String? profileImageUrl;
  final bool hasUnseen;
  final bool isOwner;
  final bool isFollowing;
  final int postCount;
  final int followerCount;
  final int followingCount;

  _Profile({
    required this.userId,
    required this.username,
    this.name,
    this.bio,
    this.profileImageUrl,
    required this.hasUnseen,
    required this.isOwner,
    required this.isFollowing,
    required this.postCount,
    required this.followerCount,
    required this.followingCount,
  });

  _Profile.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      name = data['name'],
      bio = data['bio'],
      profileImageUrl = data['profileImageUrl'],
      hasUnseen = data['hasUnseen'],
      isOwner = data['isOwner'],
      isFollowing = data['isFollowing'],
      postCount = data['postCount'],
      followerCount = data['followerCount'],
      followingCount = data['followingCount'];

  _Profile copyWith({
    int? userId,
    String? username,
    String? name,
    String? bio,
    String? profileImageUrl,
    bool? hasUnseen,
    bool? isOwner,
    bool? isFollowing,
    int? postCount,
    int? followerCount,
    int? followingCount,
  }) {
    return _Profile(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      hasUnseen: hasUnseen ?? this.hasUnseen,
      isOwner: isOwner ?? this.isOwner,
      isFollowing: isFollowing ?? this.isFollowing,
      postCount: postCount ?? this.postCount,
      followerCount: followerCount ?? this.followerCount,
      followingCount: followingCount ?? this.followingCount,
    );
  }
}

class _PostListObject {
  final int current;
  final int size;
  final int totalCount;
  final int totalPage;
  final int prev;
  final int next;
  final bool isFirst;
  final bool isLast;
  final List<_PostItem> postList;

  _PostListObject({
    required this.current,
    required this.size,
    required this.totalCount,
    required this.totalPage,
    required this.prev,
    required this.next,
    required this.isFirst,
    required this.isLast,
    required this.postList,
  });

  _PostListObject.fromMap(Map<String, dynamic> data)
    : current = data['current'],
      size = data['size'],
      totalCount = data['totalCount'],
      totalPage = data['totalPage'],
      prev = data['prev'],
      next = data['next'],
      isFirst = data['isFirst'],
      isLast = data['isLast'],
      postList = (data['postList'] as List)
          .map((data) => _PostItem.fromMap(data))
          .toList();

  _PostListObject copyWith({
    int? current,
    int? size,
    int? totalCount,
    int? totalPage,
    int? prev,
    int? next,
    bool? isFirst,
    bool? isLast,
    List<_PostItem>? postList,
  }) {
    return _PostListObject(
      current: current ?? this.current,
      size: size ?? this.size,
      totalCount: totalCount ?? this.totalCount,
      totalPage: totalPage ?? this.totalPage,
      prev: prev ?? this.prev,
      next: next ?? this.next,
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
      postList: postList ?? this.postList,
    );
  }
}

class _PostItem {
  final int postId;
  final String postImageUrl;

  _PostItem({
    required this.postId,
    required this.postImageUrl,
  });

  _PostItem.fromMap(Map<String, dynamic> data)
    : postId = data['postId'],
      postImageUrl = data['postImageUrl'];

  _PostItem copyWith({
    int? postId,
    String? postImageUrl,
  }) {
    return _PostItem(
      postId: postId ?? this.postId,
      postImageUrl: postImageUrl ?? this.postImageUrl,
    );
  }
}

class _StoryListObject {
  final int current;
  final int size;
  final int totalCount;
  final int totalPage;
  final int prev;
  final int next;
  final bool isFirst;
  final bool isLast;
  final List<_StoryItem> storyList;

  _StoryListObject({
    required this.current,
    required this.size,
    required this.totalCount,
    required this.totalPage,
    required this.prev,
    required this.next,
    required this.isFirst,
    required this.isLast,
    required this.storyList,
  });

  _StoryListObject.fromMap(Map<String, dynamic> data)
    : current = data['current'],
      size = data['size'],
      totalCount = data['totalCount'],
      totalPage = data['totalPage'],
      prev = data['prev'],
      next = data['next'],
      isFirst = data['isFirst'],
      isLast = data['isLast'],
      storyList = (data['storyList'] as List)
          .map((data) => _StoryItem.fromMap(data))
          .toList();

  _StoryListObject copyWith({
    int? current,
    int? size,
    int? totalCount,
    int? totalPage,
    int? prev,
    int? next,
    bool? isFirst,
    bool? isLast,
    List<_StoryItem>? storyList,
  }) {
    return _StoryListObject(
      current: current ?? this.current,
      size: size ?? this.size,
      totalCount: totalCount ?? this.totalCount,
      totalPage: totalPage ?? this.totalPage,
      prev: prev ?? this.prev,
      next: next ?? this.next,
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
      storyList: storyList ?? this.storyList,
    );
  }
}

class _StoryItem {
  final int storyId;
  final String thumbnailUrl;

  _StoryItem({
    required this.storyId,
    required this.thumbnailUrl,
  });

  _StoryItem.fromMap(Map<String, dynamic> data)
    : storyId = data['storyId'],
      thumbnailUrl = data['thumbnailUrl'];

  _StoryItem copyWith({
    int? storyId,
    String? thumbnailUrl,
  }) {
    return _StoryItem(
      storyId: storyId ?? this.storyId,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
    );
  }
}
