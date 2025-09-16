/// 책임 -> 통신 & 파싱(body data)
class PostRepository {
  Future<Map<String, dynamic>> getList({int page = 0}) async {
    // Response response = await dio.get("/s/api/feed/posts", queryParameters: {"page": page});
    // final responseBody = response.data;
    // Logger().d(responseBody);
    // return responseBody;

    // 1. 통신 코드
    final response = await Future.delayed(
      Duration(seconds: 2),
      () {
        return _mockGetListResponse;
      },
    );

    // 2. 리턴
    return response;
  }

  Future<Map<String, dynamic>> getSearchResultList({
    int page = 0,
    String keyword = "",
  }) async {
    print(keyword);
    // final query = {
    //   "page": page,
    //   if (keyword.isNotEmpty) "keyword": keyword, // 빈 문자열이면 아예 제외됨
    // };

    // Response response = await dio.get(
    //   "/s/api/search/posts",
    //   queryParameters: query,
    // );
    // final responseBody = response.data;
    // Logger().d(responseBody);
    // return responseBody;

    // 1. 통신 코드
    final response = await Future.delayed(
      Duration(seconds: 2),
      () {
        return _mockGetSearchResultListResponse;
      },
    );

    // 2. 리턴
    return response;
  }
}

// 가짜 데이터
final Map<String, dynamic> _mockGetListResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "current": 2,
    "size": 2,
    "totalCount": 18,
    "totalPage": 3,
    "prev": 1,
    "next": 2,
    "isFirst": false,
    "isLast": false,
    "postList": [
      {
        "isAdvertisement": false,
        "postId": 4,
        "content": "Spring Boot + JPA 연동 성공! 🚀",
        "isOwner": true,
        "isLiked": false,
        "likesCount": 2,
        "commentCount": 0,
        "createdAt": "2025-09-12T14:41:44",
        "user": {
          "userId": 2,
          "username": "ssar",
          "profileImageUrl": "https://picsum.photos/seed/ssar/200",
          "isFollowing": true,
        },
        "postImageList": [
          {
            "postImageId": 6,
            "url": "https://picsum.photos/seed/ssar2_a/800/600",
          },
        ],
      },
      {
        "isAdvertisement": false,
        "postId": 3,
        "content": "오늘은 DB 설계 공부 중 📚",
        "isOwner": true,
        "isLiked": false,
        "likesCount": 3,
        "commentCount": 5,
        "createdAt": "2025-09-12T14:41:44",
        "user": {
          "userId": 3,
          "username": "love",
          "profileImageUrl": "https://picsum.photos/seed/ssar/200",
          "isFollowing": false,
        },
        "postImageList": [
          {
            "postImageId": 4,
            "url": "https://picsum.photos/seed/ssar1_a/800/600",
          },
          {
            "postImageId": 5,
            "url": "https://picsum.photos/seed/ssar1_b/800/600",
          },
        ],
      },
    ],
  },
};

final Map<String, dynamic> _mockGetSearchResultListResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "current": 0,
    "size": 12,
    "totalCount": 4,
    "totalPage": 1,
    "prev": 0,
    "next": 0,
    "isFirst": true,
    "isLast": false,
    "postList": [
      {
        "postId": 21,
        "postImageUrl": "https://picsum.photos/seed/luna11_a/800/600",
        "content": "오늘의 추천 음악 🎶",
      },
      {
        "postId": 17,
        "postImageUrl": "https://picsum.photos/seed/luna7_a/800/600",
        "content": "오늘도 구독해주셔서 감사합니다 🙏",
      },
      {
        "postId": 11,
        "postImageUrl": "https://picsum.photos/seed/luna1_a/800/600",
        "content": "오늘 업로드한 영상 봐주세요 🎥",
      },
      {
        "postId": 3,
        "postImageUrl": "https://picsum.photos/seed/ssar1_a/800/600",
        "content": "오늘은 DB 설계 공부 중 📚",
      },
    ],
  },
};
