class LikeRepository {
  // 팔로우 등록
  Future<Map<String, dynamic>> addLike(int postId) async {
    // final response = await dio.post("/s/api/posts/{postId}/like");
    // return response.data;

    // Mock
    return {
      "status": 200,
      "msg": "성공",
      "body": {"count": 2, "isLiked": true},
    };
  }

  // 팔로우 취소
  Future<Map<String, dynamic>> removeLike(int postId) async {
    // final response = await dio.delete("/s/api/posts/{postId}/like");
    // return response.data;

    // Mock
    return {
      "status": 200,
      "msg": "성공",
      "body": {"count": 1, "isLiked": false},
    };
  }
}
