import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/data/repository/comment_repository.dart';

final postCommentProvider = AutoDisposeNotifierProvider.family<PostCommentVM, PostCommentModel?, int>(
  () {
    return PostCommentVM();
  },
);

class PostCommentVM extends AutoDisposeFamilyNotifier<PostCommentModel?, int> {
  @override
  PostCommentModel? build(int postId) {
    _fetchComments(postId);
    return null;
  }

  Future<void> _fetchComments(int postId, {int page = 0, int size = 10}) async {
    final repo = CommentRepository();
    final responseBody = await repo.fetchComments(postId, page: page, size: size);
    state = PostCommentModel.fromJson(responseBody["body"]);
  }

  Future<void> refresh(int postId) async {
    final repo = CommentRepository();
    final responseBody = await repo.fetchComments(postId, page: 0, size: state?.size ?? 10);
    state = PostCommentModel.fromJson(responseBody["body"]);
  }

  Future<void> loadMore(int postId) async {
    if (state == null || state!.isLast) return;
    final nextPage = state!.next;

    final repo = CommentRepository();
    final responseBody = await repo.fetchComments(postId, page: nextPage, size: state!.size);
    final nextData = PostCommentModel.fromJson(responseBody["body"]);

    state = PostCommentModel(
      comments: [...state!.comments, ...nextData.comments],
      current: nextData.current,
      size: nextData.size,
      totalCount: nextData.totalCount,
      totalPage: nextData.totalPage,
      prev: nextData.prev,
      next: nextData.next,
      isFirst: nextData.isFirst,
      isLast: nextData.isLast,
    );
  }
}

// 실제 댓글 1개 단위
class PostComment {
  final int commentId;
  final int? rootId;
  final int? parentId;
  final String content;
  final bool isOwner;
  final bool isLiked;
  final int likeCount;
  final DateTime createdAt;
  final PostUser user;
  final List<PostComment> replies;

  PostComment({
    required this.commentId,
    this.rootId,
    this.parentId,
    required this.content,
    required this.isOwner,
    required this.isLiked,
    required this.likeCount,
    required this.createdAt,
    required this.user,
    this.replies = const [],
  });

  factory PostComment.fromJson(Map<String, dynamic> json) {
    return PostComment(
      commentId: json["commentId"],
      rootId: json["rootId"],
      parentId: json["parentId"],
      content: json["content"],
      isOwner: json["isOwner"],
      isLiked: json["isLiked"],
      likeCount: json["likeCount"],
      createdAt: DateTime.parse(json["createdAt"]),
      user: PostUser.fromJson(json["user"]),
    );
  }

  PostComment copyWith({
    List<PostComment>? replies,
  }) {
    return PostComment(
      commentId: commentId,
      rootId: rootId,
      parentId: parentId,
      content: content,
      isOwner: isOwner,
      isLiked: isLiked,
      likeCount: likeCount,
      createdAt: createdAt,
      user: user,
      replies: replies ?? this.replies,
    );
  }
}

// 유저
class PostUser {
  final int userId;
  final String username;
  final String? profileImageUrl;
  final bool hasUnseen;

  PostUser({
    required this.userId,
    required this.username,
    this.profileImageUrl,
    required this.hasUnseen,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      userId: json["userId"],
      username: json["username"],
      profileImageUrl: json["profileImageUrl"],
      hasUnseen: json["hasUnseen"],
    );
  }
}

// 댓글 리스트 + 페이징 정보 묶는 모델
class PostCommentModel {
  final List<PostComment> comments;
  final int current;
  final int size;
  final int totalCount;
  final int totalPage;
  final int prev;
  final int next;
  final bool isFirst;
  final bool isLast;

  PostCommentModel({
    required this.comments,
    required this.current,
    required this.size,
    required this.totalCount,
    required this.totalPage,
    required this.prev,
    required this.next,
    required this.isFirst,
    required this.isLast,
  });

  factory PostCommentModel.fromJson(Map<String, dynamic> json) {
    return PostCommentModel(
      comments: (json["commentList"] as List<dynamic>).map((e) => PostComment.fromJson(e)).toList(),
      current: json["current"],
      size: json["size"],
      totalCount: json["totalCount"],
      totalPage: json["totalPage"],
      prev: json["prev"],
      next: json["next"],
      isFirst: json["isFirst"],
      isLast: json["isLast"],
    );
  }
}
