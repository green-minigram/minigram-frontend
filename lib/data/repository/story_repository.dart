import 'package:logger/logger.dart';

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

    // Mock 데이터
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "user": {
          "userId": 2,
          "username": "ssar",
          "profileImageUrl": "https://picsum.photos/seed/ssar/200",
        },
        "story": {
          "storyId": 1,
          "videoUrl": "https://www.pexels.com/ko-kr/download/video/32332683/",
          "thumbnailUrl": "https://picsum.photos/seed/story01/400/300",
          "createdAt": "2025-09-08T03:06:29",
        },
        "isFollowing": false,
        "isOwner": false,
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
        "videoUrl":
            "https://cdn.pixabay.com/video/2015/08/08/125-135736646_large.mp4",
        "thumbnailUrl": "https://picsum.photos/seed/story01/400/300",
        "status": "DELETED",
        "createdAt": "2025-09-08T04:26:54",
        "updatedAt": "2025-09-08T04:26:54",
      },
    };
    return responseBody;
  }

  /// 프리뷰 스토리 조회
  Future<Map<String, dynamic>> getPreviewList({int page = 0}) async {
    // Response response = await dio.get("/s/api/feed/story-previews", queryParameters: {"page": page});
    // final responseBody = response.data;
    // Logger().d(responseBody);
    // return responseBody;

    // 1. 통신 코드
    final response = await Future.delayed(
      Duration(seconds: 2),
      () {
        return _mockPreviewListResponse;
      },
    );

    // 2. 리턴
    return response;
  }

  /// 스토리 최근 5건 조회
  Future<Map<String, dynamic>> getRecent(int userId) async {
    Logger().d('getRecent 호출');
    // 실제 통신
    // final response = await dio.get(
    //   /s/api/feed/users/$userId/stories
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
        "storyList": [
          {
            "user": {
              "userId": 3,
              "username": "cos",
              "profileImageUrl": "https://picsum.photos/200/200",
            },
            "story": {
              "storyId": 1,
              "videoUrl":
                  "https://www.pexels.com/ko-kr/download/video/32332683/",
              "thumbnailUrl": "https://picsum.photos/seed/story02/400/300",
              "createdAt": "2025-09-08T04:04:47",
            },
            "isFollowing": true,
            "isOwner": false,
            "isLiked": true,
            "likeCount": 4,
          },
          {
            "user": {
              "userId": 3,
              "username": "cos",
              "profileImageUrl": "https://picsum.photos/200/200",
            },
            "story": {
              "storyId": 2,
              "videoUrl":
                  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
              "thumbnailUrl": "https://picsum.photos/seed/story02/400/300",
              "createdAt": "2025-09-08T04:04:47",
            },
            "isFollowing": true,
            "isOwner": true,
            "isLiked": false,
            "likeCount": 4,
          },
          {
            "user": {
              "userId": 3,
              "username": "cos",
              "profileImageUrl": "https://picsum.photos/200/200",
            },
            "story": {
              "storyId": 3,
              "videoUrl":
                  "https://www.pexels.com/ko-kr/download/video/32332683/",
              "thumbnailUrl": "https://picsum.photos/seed/story02/400/300",
              "createdAt": "2025-09-08T04:04:47",
            },
            "isFollowing": true,
            "isOwner": true,
            "isLiked": false,
            "likeCount": 4,
          },
        ],
      },
    };
    Logger().d('getRecent data : $responseBody');
    return responseBody;
  }

  // TODO 좋아요 통신 추가해야 됨
  Future toggleLike(int storyId) async {}


}

final Map<String, dynamic> _mockPreviewListResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "current": 0,
    "size": 10,
    "totalCount": 4,
    "totalPage": 1,
    "prev": 0,
    "next": 0,
    "isFirst": true,
    "isLast": false,
    "previewList": [
      {
        "userId": 8,
        "username": "luna",
        "profileImageUrl": null,
        "hasUnseen": true,
      },
      {
        "userId": 5,
        "username": "mango",
        "profileImageUrl": "https://picsum.photos/seed/mango/200",
        "hasUnseen": true,
      },
      {
        "userId": 4,
        "username": "love",
        "profileImageUrl": null,
        "hasUnseen": true,
      },
      {
        "userId": 3,
        "username": "cos",
        "profileImageUrl": "https://picsum.photos/seed/cos/200",
        "hasUnseen": true,
      },
    ],
  },
};
