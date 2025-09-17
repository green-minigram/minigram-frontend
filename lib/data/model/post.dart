import 'package:minigram/data/model/user.dart';

class Post {
  final int postId;
  final String? content;
  final bool isLiked;
  final bool isOwner;
  final int likesCount;
  final int commentCount;
  final String createdAt;
  final User user;
  final List<PostImageModel> postImageList;

  Post({
    required this.postId,
    this.content,
    required this.isLiked,
    required this.isOwner,
    required this.likesCount,
    required this.commentCount,
    required this.createdAt,
    required this.user,
    required this.postImageList,
  });

  Post.fromMap(Map<String, dynamic> data)
    : postId = data['postId'],
      content = data['content'],
      isLiked = data['isLiked'],
      isOwner = data['isOwner'],
      likesCount = data['likesCount'],
      commentCount = data['commentCount'],
      createdAt = data['createdAt'],
      user = User.fromMap(data['user']),
      postImageList = (data['postImageList'] as List)
          .map((data) => PostImageModel.fromMap(data))
          .toList();

  /// 좋아요 누를때 사용할 것 같음
  Post copyWith({
    int? postId,
    String? content,
    bool? isLiked,
    bool? isOwner,
    int? likesCount,
    int? commentCount,
    String? createdAt,
    User? user,
    List<PostImageModel>? postImageList,
  }) {
    return Post(
      postId: postId ?? this.postId,
      content: content ?? this.content,
      isLiked: isLiked ?? this.isLiked,
      isOwner: isOwner ?? this.isOwner,
      likesCount: likesCount ?? this.likesCount,
      commentCount: commentCount ?? this.commentCount,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
      postImageList: postImageList ?? this.postImageList,
    );
  }
}

class PostImageModel {
  final int postImageId;
  final String url;

  PostImageModel({
    required this.postImageId,
    required this.url,
  });

  PostImageModel.fromMap(Map<String, dynamic> data)
    : postImageId = data['postImageId'],
      url = data['url'];
}
