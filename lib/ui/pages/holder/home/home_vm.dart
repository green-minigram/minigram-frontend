import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/data/repository/follow_repository.dart';
import 'package:minigram/data/repository/like_repository.dart';
import 'package:minigram/data/repository/post_repository.dart';
import 'package:minigram/data/repository/story_repository.dart';
import 'package:minigram/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 1. 창고 관리자
final homeProvider = AutoDisposeNotifierProvider<HomeVM, HomeModel?>(() {
  return HomeVM();
});

/// 2. 창고
class HomeVM extends AutoDisposeNotifier<HomeModel?> {
  final mContext = navigatorKey.currentContext!;
  final verticalScrollController = RefreshController();
  final horizontalScrollController = RefreshController();

  @override
  HomeModel? build() {
    init();

    ref.onDispose(() {
      verticalScrollController.dispose();
      horizontalScrollController.dispose();
      Logger().d("HomeVM 파괴됨");
    });

    return null;
  }

  Future<void> init({int page = 0}) async {
    /// 게시글 목록 조회
    Map<String, dynamic> postBody = await PostRepository().getList(page: page);
    if (postBody["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 목록보기 실패 : ${postBody["msg"]}")),
      );
      return;
    }

    /// 스토리 프리뷰 조회
    Map<String, dynamic> storyPreview = await StoryRepository().getPreviewList(
      page: page,
    );
    if (storyPreview["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("스토리 프리뷰 목록보기 실패 : ${storyPreview["msg"]}")),
      );
      return;
    }

    state = HomeModel.fromMap(
      postObject: postBody["body"],
      storyObject: storyPreview["body"],
    );

    verticalScrollController.refreshCompleted();
  }

  // void notifyUpdateOne(Post post) {
  //   List<Post> nextPosts = state!.posts.map((p) => p.id == post.id ? post : p).toList();
  //
  //   state = state!.copyWith(posts: nextPosts);
  // }
  //
  // void notifyDeleteOne(int postId) {
  //   HomeModel model = state!;
  //
  //   model.posts = model.posts.where((p) => p.id != postId).toList();
  //
  //   state = state!.copyWith(posts: model.posts);
  // }
  //
  // Future<void> write(String title, String content) async {
  //   // 1. 레포지토리 함수 호출
  //   Map<String, dynamic> body = await PostRepository().write(title, content);
  //
  //   // 2. 성공 여부 확인
  //   if (!body["success"]) {
  //     ScaffoldMessenger.of(mContext).showSnackBar(
  //       SnackBar(content: Text("게시글 쓰기 실패 : ${body["errorMessage"]}")),
  //     );
  //     return;
  //   }
  //
  //   // 3. 상태 갱신
  //   // 3-1. 파싱
  //   Post post = Post.fromMap(body["response"]);
  //
  //   // 3-2. 상태 변경
  //   List<Post> nextPosts = [post, ...state!.posts];
  //
  //   // 3-3. 상태 갱신
  //   state = state!.copyWith(posts: nextPosts);
  //
  //   // 4. 글쓰기 화면 pop
  //   Navigator.pop(mContext);
  // }
  //
  Future<void> nextPostList() async {
    HomeModel prevModel = state!;

    if (prevModel.postObject.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      verticalScrollController.loadComplete();
      return;
    }

    Map<String, dynamic> body = await PostRepository().getList(
      page: prevModel.postObject.next,
    );
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 로딩 실패 : ${body["msg"]}")),
      );
      verticalScrollController.loadComplete();
      return;
    }

    _PostObject nextPostObject = _PostObject.fromMap(body['body']);

    state = prevModel.copyWith(
      postObject: prevModel.postObject.copyWith(
        current: nextPostObject.current,
        size: nextPostObject.size,
        totalCount: nextPostObject.totalCount,
        totalPage: nextPostObject.totalPage,
        prev: nextPostObject.prev,
        next: nextPostObject.next,
        isFirst: nextPostObject.isFirst,
        isLast: nextPostObject.isLast,
        postList: [
          ...prevModel.postObject.postList,
          ...nextPostObject.postList,
        ],
      ),
    );
    verticalScrollController.loadComplete();
  }

  Future<void> nextPreviewList() async {
    HomeModel prevModel = state!;

    if (prevModel.storyObject.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      horizontalScrollController.loadComplete();
      return;
    }

    Map<String, dynamic> body = await StoryRepository().getPreviewList(
      page: prevModel.storyObject.next,
    );
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("프리뷰 로딩 실패 : ${body["msg"]}")),
      );
      horizontalScrollController.loadComplete();
      return;
    }

    _StoryObject nextStoryObject = _StoryObject.fromMap(body['body']);

    state = prevModel.copyWith(
      storyObject: prevModel.storyObject.copyWith(
        current: nextStoryObject.current,
        size: nextStoryObject.size,
        totalCount: nextStoryObject.totalCount,
        totalPage: nextStoryObject.totalPage,
        prev: nextStoryObject.prev,
        next: nextStoryObject.next,
        isFirst: nextStoryObject.isFirst,
        isLast: nextStoryObject.isLast,
        previewList: [
          ...prevModel.storyObject.previewList,
          ...nextStoryObject.previewList,
        ],
      ),
    );
    horizontalScrollController.loadComplete();
  }

  Future<void> toggleFollow(int userId) async {
    // postList에서 해당 userId를 가진 post의 user를 찾음
    final prevModel = state!;
    final postList = prevModel.postObject.postList;

    // postList에서 해당 userId를 가진 post의 인덱스 찾기
    final idx = postList.indexWhere((post) => post.user.userId == userId);
    if (idx == -1) return;

    final post = postList[idx];
    final isFollowing = post.user.isFollowing ?? false;

    try {
      // 팔로우/언팔로우 API 호출
      if (isFollowing) {
        Logger().d("언팔로우 요청함");
        await FollowRepository().unfollow(userId);
      } else {
        Logger().d("팔로우 요청함");
        await FollowRepository().follow(userId);
      }

      // postList의 해당 user의 isFollowing 상태를 불변으로 토글
      final updatedUser = post.user.copyWith(isFollowing: !isFollowing);
      final updatedPost = post.copyWith(user: updatedUser);
      final updatedPostList = List<Post>.from(postList);
      updatedPostList[idx] = updatedPost;

      // 상태 갱신
      state = prevModel.copyWith(
        postObject: prevModel.postObject.copyWith(
          postList: updatedPostList,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("팔로우 상태 변경 실패: $e")),
      );
    }
  }

  Timer? _likeDebounce;

  Future<void> toggleLike(int postId) async {
    if (state == null) return;

    final prevModel = state!;
    final postList = prevModel.postObject.postList;

    // postId에 해당하는 post 찾기
    final idx = postList.indexWhere((post) => post.postId == postId);
    if (idx == -1) return;

    final post = postList[idx];
    final isLiked = post.isLiked ?? false;
    final likesCount = post.likesCount ?? 0;

    // 1) UI 먼저 토글
    final updatedPost = post.copyWith(
      isLiked: !isLiked,
      likesCount: isLiked ? (likesCount - 1) : (likesCount + 1),
    );

    final updatedPostList = List<Post>.from(postList);
    updatedPostList[idx] = updatedPost;

    state = prevModel.copyWith(
      postObject: prevModel.postObject.copyWith(
        postList: updatedPostList,
      ),
    );
    Logger().d(
      "좋아요 상태 변경 (UI 반영): ${updatedPost.isLiked}, likesCount=${updatedPost.likesCount}",
    );

    // 2) 디바운스 → 마지막 액션만 서버로 반영
    _likeDebounce?.cancel();
    _likeDebounce = Timer(const Duration(milliseconds: 500), () async {
      try {
        Logger().d("좋아요 통신 시작 (postId=$postId)");
        if (updatedPost.isLiked) {
          await LikeRepository().addPostLike(postId);
        } else {
          await LikeRepository().removeLike(postId);
        }
        Logger().d("좋아요 통신 성공 (postId=$postId)");
      } catch (e) {
        Logger().e("좋아요 통신 오류: $e");
        // 실패 시 UI 롤백도 고려 가능
      }
    });
  }
}

/// 3. 창고 데이터 타입
class HomeModel {
  final _StoryObject storyObject;
  final _PostObject postObject;

  HomeModel({
    required this.storyObject,
    required this.postObject,
  });

  HomeModel.fromMap({
    required Map<String, dynamic> postObject,
    required Map<String, dynamic> storyObject,
  }) : postObject = _PostObject.fromMap(postObject),
       storyObject = _StoryObject.fromMap(storyObject);

  HomeModel copyWith({
    _StoryObject? storyObject,
    _PostObject? postObject,
  }) {
    return HomeModel(
      postObject: postObject ?? this.postObject,
      storyObject: storyObject ?? this.storyObject,
    );
  }
}

class _PostObject {
  final int current;
  final int size;
  final int totalCount;
  final int totalPage;
  final int prev;
  final int next;
  final bool isFirst;
  final bool isLast;
  final List<Post> postList;

  _PostObject({
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

  _PostObject.fromMap(Map<String, dynamic> data)
    : current = data['current'],
      size = data['size'],
      totalCount = data['totalCount'],
      totalPage = data['totalPage'],
      prev = data['prev'],
      next = data['next'],
      isFirst = data['isFirst'],
      isLast = data['isLast'],
      postList = (data['postList'] as List)
          .map((data) => Post.fromMap(data))
          .toList();

  _PostObject copyWith({
    int? current,
    int? size,
    int? totalCount,
    int? totalPage,
    int? prev,
    int? next,
    bool? isFirst,
    bool? isLast,
    List<Post>? postList,
  }) {
    return _PostObject(
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

class _StoryObject {
  final int current;
  final int size;
  final int totalCount;
  final int totalPage;
  final int prev;
  final int next;
  final bool isFirst;
  final bool isLast;
  final List<_Preview> previewList;

  _StoryObject({
    required this.current,
    required this.size,
    required this.totalCount,
    required this.totalPage,
    required this.prev,
    required this.next,
    required this.isFirst,
    required this.isLast,
    required this.previewList,
  });

  _StoryObject.fromMap(Map<String, dynamic> data)
    : current = data['current'],
      size = data['size'],
      totalCount = data['totalCount'],
      totalPage = data['totalPage'],
      prev = data['prev'],
      next = data['next'],
      isFirst = data['isFirst'],
      isLast = data['isLast'],
      previewList = (data['previewList'] as List)
          .map((data) => _Preview.fromMap(data))
          .toList();

  _StoryObject copyWith({
    int? current,
    int? size,
    int? totalCount,
    int? totalPage,
    int? prev,
    int? next,
    bool? isFirst,
    bool? isLast,
    List<_Preview>? previewList,
  }) {
    return _StoryObject(
      current: current ?? this.current,
      size: size ?? this.size,
      totalCount: totalCount ?? this.totalCount,
      totalPage: totalPage ?? this.totalPage,
      prev: prev ?? this.prev,
      next: next ?? this.next,
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
      previewList: previewList ?? this.previewList,
    );
  }
}

class _Preview {
  final int userId;
  final String username;
  final String? profileImageUrl;
  final bool hasUnseen;

  _Preview({
    required this.userId,
    required this.username,
    this.profileImageUrl,
    required this.hasUnseen,
  });

  _Preview.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      profileImageUrl = data['profileImageUrl'],
      hasUnseen = data['hasUnseen'];

  _Preview copyWith({
    int? userId,
    String? username,
    String? profileImageUrl,
    bool? hasUnseen,
  }) {
    return _Preview(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      hasUnseen: hasUnseen ?? this.hasUnseen,
    );
  }
}
