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
}

// 가짜 데이터
final Map<String, dynamic> _mockGetListResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "current": 0,
    "size": 10,
    "totalCount": 17,
    "totalPage": 2,
    "prev": 0,
    "next": 1,
    "isFirst": true,
    "isLast": false,
    "postList": [
      {
        "postId": 23,
        "content": "팔로워 1만 명 감사합니다 🎉",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 45,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 46,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 22,
        "content": "촬영 장소 비하인드 공개 🏞️",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 44,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 21,
        "content": "오늘의 추천 음악 🎶",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 43,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 20,
        "content": "댓글 이벤트 진행 중 🎁",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 41,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 42,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 19,
        "content": "여행 브이로그 준비 중 ✈️",
        "isLiked": true,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 40,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 18,
        "content": "브이로그: 하루 일상 ☀️",
        "isLiked": true,
        "likesCount": 8,
        "commentCount": 15,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 30,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 31,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 32,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 33,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 34,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 35,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 36,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 37,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 38,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 39,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 17,
        "content": "오늘도 구독해주셔서 감사합니다 🙏",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 29,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 16,
        "content": "내가 쓰는 장비 소개 🎥",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 28,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 15,
        "content": "편집하다가 밤샜다 😵",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 23,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 24,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 25,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 26,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
          {
            "postImageId": 27,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
      {
        "postId": 14,
        "content": "팬들과 함께하는 라이브 Q&A 🎤",
        "isLiked": false,
        "likesCount": 1,
        "commentCount": 0,
        "createdAt": "2025-09-11T03:16:03",
        "user": {"userId": 8, "username": "luna", "profileImageUrl": null},
        "postImageList": [
          {
            "postImageId": 22,
            "url": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          },
        ],
      },
    ],
  },
};

final Map<String, dynamic> _mockLoginResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "accessToken":
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJtaW5pZ3JhbSIsInJvbGVzIjoiQURNSU4sIFVTRVIiLCJpZCI6MSwiZXhwIjoxNzU4MzM3NTg3fQ.51dGvjfz0IFBOqOimk-1fKDKxsRV4-W7AdqxNzMOB9uTAutvB9nM2zVET19sXuTKhsc4y7lYzLDdx0je12Fm1w",
    "userId": 1,
    "username": "minigram",
    "roles": "ADMIN, USER",
  },
};
