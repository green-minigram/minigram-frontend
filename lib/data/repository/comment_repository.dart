import 'package:minigram/_core/util/my_http.dart';

class CommentRepository {
  // 게시글 댓글 조회
  Future<Map<String, dynamic>> fetchComments(int postId, {int page = 0, int size = 10}) async {
    final response = await dio.get(
      "/s/api/posts/$postId/comments",
      queryParameters: {
        "page": page,
        "size": size,
      },
    );

    final responseBody = response.data;
    return responseBody;
  }

  // 특정 댓글 대댓글 조회
  Future<Map<String, dynamic>> fetchReplies(int commentId, {int page = 0, int size = 10}) async {
    final response = await dio.get(
      "/s/api/comments/$commentId/replies",
      queryParameters: {
        "page": page,
        "size": size,
      },
    );

    final responseBody = response.data;
    return responseBody;
  }
}
