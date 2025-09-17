import 'package:minigram/_core/util/my_http.dart';

class LikeRepository {
  // 게시글 좋아요 등록
  Future<Map<String, dynamic>> addPostLike(int postId) async {
    final response = await dio.post("/s/api/posts/{postId}/like");
    return response.data;

    // // Mock
    // return {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {"count": 2, "isLiked": true},
    // };
  }

  // 게시글 좋아요 취소
  Future<Map<String, dynamic>> removePostLike(int postId) async {
    final response = await dio.delete("/s/api/posts/{postId}/like");
    return response.data;

    // // Mock
    // return {
    //   "status": 200,
    //   "msg": "성공",
    //   "body": {"count": 1, "isLiked": false},
    // };
  }
}
