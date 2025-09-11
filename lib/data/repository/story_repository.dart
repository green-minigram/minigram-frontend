/// 책임 -> 통신 & 파싱(body data)
class StoryRepository {
  /// 스토리 조회
  Future<Map<String, dynamic>> getOne(int storyId) async {
    // final response = await dio.get("/s/api/stories/$storyId");
    // if (response.statusCode == 200) {
    //   final responseBody = response.data as Map<String, dynamic>;
    //   Logger().d('스토리 단건 조회: $responseBody');
    //   return responseBody; // status, msg, body 포함 전체 반환
    // } else {
    //   throw Exception("스토리 조회 실패: ${response.statusCode}");
    // }
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "user": {"userId": 2, "username": "ssar", "profileImageUrl": "https://picsum.photos/seed/ssar/200"},
        "story": {
          "storyId": 1,
          "videoUrl": "https://www.pexels.com/ko-kr/download/video/32332683/",
          "thumbnailUrl": "https://picsum.photos/seed/story01/400/300",
          "createdAt": "2025-09-08T03:06:29",
        },
        "isFollowing": false,
        "isOwner": true,
        "isLiked": true,
        "likeCount": 5,
      },
    };
    return responseBody;
  }

  /// 스토리 삭제
  Future<Map<String, dynamic>> delete(int storyId) async {
    // 실제 통신
    // final response = await dio.delete(
    //   "/s/api/stories/$storyId",
    //   data: {"videoUrl": "dummy.png"},
    // );
    // if (response.statusCode == 200) {
    //   return response.data as Map<String, dynamic>;
    // } else {
    //   throw Exception("스토리 삭제 실패: ${response.statusCode}");
    // }

    // Mock 데이터
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "storyId": storyId,
        "userId": 2,
        "videoUrl": "https://cdn.pixabay.com/video/2015/08/08/125-135736646_large.mp4",
        "thumbnailUrl": "https://picsum.photos/seed/story01/400/300",
        "status": "DELETED",
        "createdAt": "2025-09-08T04:26:54",
        "updatedAt": "2025-09-08T04:26:54",
      },
    };
    return responseBody;
  }
}

// 가짜 데이터
final Map<String, dynamic> _mockJoinResponse = {
  "status": 200,
  "msg": "성공",
  "body": {"userId": 11, "username": "test", "roles": "USER"},
};
