import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/data/model/story.dart';
import 'package:minigram/data/repository/post_repository.dart';
import 'package:minigram/data/repository/story_repository.dart';
import 'package:minigram/main.dart';
import 'package:minigram/ui/pages/story/write/widget/story_preview.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 1. 창고 관리자
final searchProvider = AutoDisposeNotifierProvider<SearchVM, SearchModel?>(() {
  return SearchVM();
});

/// 2. 창고
class SearchVM extends AutoDisposeNotifier<SearchModel?> {
  final mContext = navigatorKey.currentContext!;
  final verticalScrollController = RefreshController();

  @override
  SearchModel? build() {
    init();

    ref.onDispose(() {
      verticalScrollController.dispose();
      Logger().d("HomeVM 파괴됨");
    });

    return null;
  }

  Future<void> init({int page = 0}) async {
    /// 게시글 목록 조회
    Map<String, dynamic> searchResultPostBody = await PostRepository()
        .getSearchResultList(page: page);
    if (searchResultPostBody["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(
          content: Text("게시글 랜덤 검색 목록 조회 실패 : ${searchResultPostBody["msg"]}"),
        ),
      );
      return;
    }

    state = SearchModel.fromMap(
      postObject: searchResultPostBody["body"],
    );

    verticalScrollController.refreshCompleted();
  }

  Future<void> nextPostList() async {
    SearchModel prevModel = state!;

    if (prevModel.postObject.isLast) {
      await Future.delayed(Duration(milliseconds: 500));
      verticalScrollController.loadComplete();
      return;
    }

    Map<String, dynamic> body = await PostRepository().getSearchResultList(
      page: prevModel.postObject.next,
    );
    if (body["status"] != 200) {
      ScaffoldMessenger.of(mContext).showSnackBar(
        SnackBar(content: Text("게시글 랜덤 검색 목록 추가 조회 실패 : ${body["msg"]}")),
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
}

/// 3. 창고 데이터 타입
class SearchModel {
  final _PostObject postObject;

  SearchModel({
    required this.postObject,
  });

  SearchModel.fromMap({
    required Map<String, dynamic> postObject,
  }) : postObject = _PostObject.fromMap(postObject);

  SearchModel copyWith({
    _PostObject? postObject,
  }) {
    return SearchModel(
      postObject: postObject ?? this.postObject,
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
  final List<_SimplePost> postList;

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

  _PostObject.fromMap(Map<String, dynamic> map)
    : current = map['current'],
      size = map['size'],
      totalCount = map['totalCount'],
      totalPage = map['totalPage'],
      prev = map['prev'],
      next = map['next'],
      isFirst = map['isFirst'],
      isLast = map['isLast'],
      postList = (map['postList'] as List)
          .map((e) => _SimplePost.fromMap(e))
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
    List<_SimplePost>? postList,
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

class _SimplePost {
  final int postId;
  final String postImageUrl;
  final String? content;

  _SimplePost({
    required this.postId,
    required this.postImageUrl,
    this.content,
  });

  _SimplePost.fromMap(Map<String, dynamic> map)
    : postId = map['postId'],
      postImageUrl = map['postImageUrl'],
      content = map['content'];

  _SimplePost copyWith({
    int? postId,
    String? postImageUrl,
    String? content,
  }) {
    return _SimplePost(
      postId: postId ?? this.postId,
      postImageUrl: postImageUrl ?? this.postImageUrl,
      content: content ?? this.content,
    );
  }
}
