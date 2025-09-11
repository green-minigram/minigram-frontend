import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/data/repository/post_repository.dart';
import 'package:minigram/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 1. 창고 관리자
final homeProvider = AutoDisposeNotifierProvider<HomeVM, HomeModel?>(() {
  return HomeVM();
});

/// 2. 창고
class HomeVM extends AutoDisposeNotifier<HomeModel?> {
  final mContext = navigatorKey.currentContext!;
  final refreshCtrlPost = RefreshController();

  @override
  HomeModel? build() {
    init();

    ref.onDispose(() {
      refreshCtrlPost.dispose();
      Logger().d("HomeVM 파괴됨");
    });

    return null;
  }

  Future<void> init({int page = 0}) async {
    Map<String, dynamic> postBody = await PostRepository().getList(page: page);
    if (postBody["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 목록보기 실패 : ${postBody["msg"]}")),
      );
      return;
    }
    state = HomeModel.fromMap(postBody["body"]);

    refreshCtrlPost.refreshCompleted();
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
  Future<void> nextList() async {
    HomeModel prevModel = state!;

    if (prevModel.postObject.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      refreshCtrlPost.loadComplete();
      return;
    }

    Map<String, dynamic> body = await PostRepository().getList(page: prevModel.postObject.next);
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 로딩 실패 : ${body["msg"]}")),
      );
      refreshCtrlPost.loadComplete();
      return;
    }

    HomeModel nextModel = HomeModel.fromMap(body["response"]);

    state = nextModel.copyWith(posts: [...prevModel.posts, ...nextModel.posts]);
    refreshCtrlPost.loadComplete();
  }
}

/// 3. 창고 데이터 타입
class HomeModel {
  // final Object? storyObject; -> 스토리 오브젝트 자리
  final PostObject postObject;

  HomeModel({
    // this.storyObject,
    required this.postObject,
  });

  HomeModel.fromMap(Map<String, dynamic> postObject) : postObject = PostObject.fromMap(postObject);

  HomeModel copyWith({
    // Object? storyObject,
    PostObject? postObject,
  }) {
    return HomeModel(
      postObject: postObject ?? this.postObject,
    );
  }
}

class PostObject {
  final int current;
  final int size;
  final int totalCount;
  final int totalPage;
  final int prev;
  final int next;
  final bool isFirst;
  final bool isLast;
  final List<Post> postList;

  PostObject({
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

  PostObject.fromMap(Map<String, dynamic> data)
    : current = data['current'],
      size = data['size'],
      totalCount = data['totalCount'],
      totalPage = data['totalPage'],
      prev = data['prev'],
      next = data['next'],
      isFirst = data['isFirst'],
      isLast = data['isLast'],
      postList = (data['postList'] as List).map((data) => Post.fromMap(data)).toList();
}
