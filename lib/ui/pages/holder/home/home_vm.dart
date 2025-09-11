import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 1. 창고 관리자
final postListProvider = AutoDisposeNotifierProvider<PostListVM, PostListModel?>(() {
  return PostListVM();
});

/// 2. 창고
class PostListVM extends AutoDisposeNotifier<PostListModel?> {
  final mContext = navigatorKey.currentContext!;
  final refreshCtrl = RefreshController();

  @override
  PostListModel? build() {
    init();

    ref.onDispose(() {
      refreshCtrl.dispose();
      Logger().d("PostListVM 파괴됨");
    });

    return null;
  }

  Future<void> init({int page = 0}) async {
    Map<String, dynamic> body = await PostRepository().getList(page: page);
    if (!body["success"]) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 목록보기 실패 : ${body["errorMessage"]}")),
      );
      return;
    }
    state = PostListModel.fromMap(body["response"]);

    refreshCtrl.refreshCompleted();
  }

  void notifyUpdateOne(Post post) {
    List<Post> nextPosts = state!.posts.map((p) => p.id == post.id ? post : p).toList();

    state = state!.copyWith(posts: nextPosts);
  }

  void notifyDeleteOne(int postId) {
    PostListModel model = state!;

    model.posts = model.posts.where((p) => p.id != postId).toList();

    state = state!.copyWith(posts: model.posts);
  }

  Future<void> write(String title, String content) async {
    // 1. 레포지토리 함수 호출
    Map<String, dynamic> body = await PostRepository().write(title, content);

    // 2. 성공 여부 확인
    if (!body["success"]) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 쓰기 실패 : ${body["errorMessage"]}")),
      );
      return;
    }

    // 3. 상태 갱신
    // 3-1. 파싱
    Post post = Post.fromMap(body["response"]);

    // 3-2. 상태 변경
    List<Post> nextPosts = [post, ...state!.posts];

    // 3-3. 상태 갱신
    state = state!.copyWith(posts: nextPosts);

    // 4. 글쓰기 화면 pop
    Navigator.pop(mContext);
  }

  Future<void> nextList() async {
    PostListModel prevModel = state!;

    if (prevModel.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      refreshCtrl.loadComplete();
      return;
    }

    Map<String, dynamic> body = await PostRepository().getList(page: prevModel.pageNumber + 1);
    if (!body["success"]) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 로딩 실패 : ${body["errorMessage"]}")),
      );
      refreshCtrl.loadComplete();
      return;
    }

    PostListModel nextModel = PostListModel.fromMap(body["response"]);

    state = nextModel.copyWith(posts: [...prevModel.posts, ...nextModel.posts]);
    refreshCtrl.loadComplete();
  }
}

/// 3. 창고 데이터 타입
class PostListModel {
  bool isFirst;
  bool isLast;
  int pageNumber;
  int size;
  int totalPage;
  List<Post> posts;

  PostListModel({
    required this.isFirst,
    required this.isLast,
    required this.pageNumber,
    required this.size,
    required this.totalPage,
    required this.posts,
  });

  PostListModel.fromMap(Map<String, dynamic> data)
    : isFirst = data['isFirst'],
      isLast = data['isLast'],
      pageNumber = data['pageNumber'],
      size = data['size'],
      totalPage = data['totalPage'],
      posts = (data['posts'] as List).map((e) => Post.fromMap(e)).toList();

  PostListModel copyWith({
    bool? isFirst,
    bool? isLast,
    int? pageNumber,
    int? size,
    int? totalPage,
    List<Post>? posts,
  }) {
    return PostListModel(
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
      pageNumber: pageNumber ?? this.pageNumber,
      size: size ?? this.size,
      totalPage: totalPage ?? this.totalPage,
      posts: posts ?? this.posts,
    );
  }

  @override
  String toString() {
    return 'PostListModel{isFirst: $isFirst, isLast: $isLast, pageNumber: $pageNumber, size: $size, totalPage: $totalPage, posts: $posts}';
  }
}
