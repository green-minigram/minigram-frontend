import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/data/model/user.dart';
import 'package:minigram/data/repository/post_repository.dart';

final postDetailProvider =
    AutoDisposeNotifierProvider.family<PostDetailVM, PostDetailModel?, int>(() {
      return PostDetailVM();
    });

class PostDetailVM extends AutoDisposeFamilyNotifier<PostDetailModel?, int> {
  @override
  PostDetailModel? build(int postId) {
    init(postId);

    ref.onDispose(() {
      Logger().d("PostDetailVM 파괴됨");
    });

    return null;
  }

  Future<void> init(int postId) async {
    final data = await PostRepository().getDetail(postId);

    if (data["status"] != 200) {
      Logger().e("게시글 상세 조회 실패: ${data["msg"]}");
      return;
    }

    final body = data["body"] as Map<String, dynamic>;
    state = PostDetailModel.fromMap(body);
  }
}

class PostDetailModel {
  final int postId;
  final Author author;
  final List<PostImages> images;
  final String content;
  final Likes likes;
  final int commentCount;
  final String postedAt;
  final bool isReported;
  final bool isAd;

  PostDetailModel({
    required this.postId,
    required this.author,
    required this.images,
    required this.content,
    required this.likes,
    required this.commentCount,
    required this.postedAt,
    required this.isReported,
    required this.isAd,
  });

  factory PostDetailModel.fromMap(Map<String, dynamic> map) {
    return PostDetailModel(
      postId: map['postId'],
      author: Author.fromMap(map['author']),
      images: (map['images'] as List)
          .map((img) => PostImages.fromMap(img))
          .toList(),
      content: map['content'],
      likes: Likes.fromMap(map['likes']),
      commentCount: map['commentCount'],
      postedAt: map['postedAt'],
      isReported: map['isReported'],
      isAd: map['isAd'],
    );
  }

  /// Post 모델로 변환 (UI에서 재사용)
  Post toPost() {
    return Post(
      postId: postId,
      content: content,
      isLiked: likes.isLiked,
      isOwner: author.isOwner,
      likesCount: likes.count,
      commentCount: commentCount,
      createdAt: postedAt,
      user: User(
        userId: author.userId,
        username: author.username,
        profileImageUrl: author.profileImageUrl,
        isFollowing: author.isFollowing,
        isOwner: author.isOwner,
      ),
      postImageList: images
          .map(
            (e) => PostImageModel(
              postImageId: e.id,
              url: e.url,
            ),
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return 'PostDetailModel(postId: $postId, author: $author, images: $images, '
        'content: $content, likes: $likes, commentCount: $commentCount, '
        'postedAt: $postedAt, isReported: $isReported, isAd: $isAd)';
  }
}

class Author {
  final int userId;
  final String username;
  final String? profileImageUrl;
  final bool isFollowing;
  final bool isOwner;

  Author({
    required this.userId,
    required this.username,
    this.profileImageUrl,
    required this.isFollowing,
    required this.isOwner,
  });

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      userId: map['userId'],
      username: map['username'],
      profileImageUrl: map['profileImageUrl'],
      isFollowing: map['isFollowing'],
      isOwner: map['isOwner'],
    );
  }
}

class PostImages {
  final int id;
  final String url;

  PostImages({
    required this.id,
    required this.url,
  });

  factory PostImages.fromMap(Map<String, dynamic> map) {
    return PostImages(
      id: map['id'],
      url: map['url'],
    );
  }
}

class Likes {
  final int count;
  final bool isLiked;

  Likes({
    required this.count,
    required this.isLiked,
  });

  factory Likes.fromMap(Map<String, dynamic> map) {
    return Likes(
      count: map['count'],
      isLiked: map['isLiked'],
    );
  }
}
