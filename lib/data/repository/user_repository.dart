import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minigram/_core/util/my_http.dart';

/// 책임 -> 통신 & 파싱(body data)
class UserRepository {
  Future<Map<String, dynamic>> join(
    String username,
    String email,
    String password,
  ) async {
    // final requestBody = {
    //   "username": username,
    //   "email": email,
    //   "password": password,
    // };
    //
    // Response response = await dio.post("/api/auth/join", data: requestBody);
    // Map<String, dynamic> responseBody = response.data;
    // Logger().d(responseBody);
    //
    // return responseBody;

    // 1. 통신 코드
    final response = await Future.delayed(
      Duration(seconds: 2),
      () {
        return _mockJoinResponse;
      },
    );

    // 2. 리턴
    return response;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final requestBody = {
      "email": email,
      "password": password,
    };

    Response response = await dio.post("/api/auth/login", data: requestBody);
    Map<String, dynamic> responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;

    // 1. 통신 코드
    // final response = await Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    //     return _mockLoginResponse;
    //   },
    // );

    // 2. 리턴
    // return response;
  }

  Future<Map<String, dynamic>> autoLogin(String accessToken) async {
    Response response = await dio.post(
      "/auto/login",
      options: Options(headers: {"Authorization": accessToken}),
    );
    Map<String, dynamic> responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;
  }

  // 추가: 아이디 중복 확인
  Future<bool> checkUsernameAvailable(String username) async {
    // 백엔드 엔드포인트에 맞게 수정
    // Response response = await dio.post("/login", data: requestBody);
    // Map<String, dynamic> responseBody = response.data;
    // Logger().d(responseBody);
    // return responseBody;
    return true;
  }

  // 추가: 이메일 중복 확인
  Future<bool> checkEmailAvailable(String email) async {
    // final Response res = await dio.get("/check/email", queryParameters: {"email": email});
    // final data = res.data as Map<String, dynamic>;
    // final available = (data["response"]?["available"]) == true;
    return true;
  }

  Future<Map<String, dynamic>> getUserProfile(int userId) async {
    Response response = await dio.get('/s/api/users/${userId}/detail');
    final responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;

    // // 1. 통신 코드
    // final response = await Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    //     return _mockUserProfileResponse;
    //   },
    // );

    // // 2. 리턴
    // return response;
  }

  Future<Map<String, dynamic>> getUserProfilePostList({
    required int userId,
    required int page,
  }) async {
    Response response = await dio.get(
      '/s/api/users/${userId}/posts',
      queryParameters: {"page": page},
    );
    final responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;

    // // 1. 통신 코드
    // final response = await Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    //     return _mockUserProfilePostListResponse;
    //   },
    // );

    // // 2. 리턴
    // return response;
  }

  Future<Map<String, dynamic>> getUserProfileStoryList({
    required int userId,
    required int page,
  }) async {
    Response response = await dio.get(
      '/s/api/users/${userId}/stories',
      queryParameters: {"page": page},
    );
    final responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;

    // // 1. 통신 코드
    // final response = await Future.delayed(
    //   Duration(seconds: 2),
    //   () {
    //     return _mockUserProfileStoryListResponse;
    //   },
    // );

    // // 2. 리턴
    // return response;
  }
}

// 가짜 데이터
final Map<String, dynamic> _mockJoinResponse = {
  "status": 200,
  "msg": "성공",
  "body": {"userId": 11, "username": "test", "roles": "USER"},
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

final Map<String, dynamic> _mockUserProfileResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "profile": {
      "userId": 2,
      "username": "ssar",
      "name": "ssar",
      "bio": "백엔드 개발자 지망생",
      "profileImageUrl": "https://picsum.photos/seed/ssar/200",
      "hasUnseen": true,
      "isOwner": true,
      "isFollowing": false,
      "postCount": 2,
      "followerCount": 5,
      "followingCount": 4,
    },
    "postList": {
      "current": 0,
      "size": 12,
      "totalCount": 2,
      "totalPage": 1,
      "prev": 0,
      "next": 0,
      "isFirst": true,
      "isLast": false,
      "postList": [
        {
          "postId": 4,
          "postImageUrl": "https://picsum.photos/seed/ssar2_a/800/600",
        },
        {
          "postId": 3,
          "postImageUrl": "https://picsum.photos/seed/ssar1_a/800/600",
        },
      ],
    },
    "storyList": {
      "current": 0,
      "size": 12,
      "totalCount": 6,
      "totalPage": 1,
      "prev": 0,
      "next": 0,
      "isFirst": true,
      "isLast": false,
      "storyList": [
        {
          "storyId": 14,
          "thumbnailUrl":
              "https://cdn.pixabay.com/video/2019/02/01/21116-315137080_tiny.jpg",
        },
        {
          "storyId": 13,
          "thumbnailUrl":
              "https://cdn.pixabay.com/video/2016/09/14/5278-182817488_tiny.jpg",
        },
        {
          "storyId": 12,
          "thumbnailUrl":
              "https://cdn.pixabay.com/video/2016/05/12/3134-166335905_tiny.jpg",
        },
        {
          "storyId": 11,
          "thumbnailUrl":
              "https://cdn.pixabay.com/video/2019/02/01/21116-315137080_tiny.jpg",
        },
        {
          "storyId": 10,
          "thumbnailUrl":
              "https://cdn.pixabay.com/video/2018/02/19/14385-256955049_tiny.jpg",
        },
        {
          "storyId": 1,
          "thumbnailUrl": "https://picsum.photos/seed/story01/400/300",
        },
      ],
    },
  },
};

final Map<String, dynamic> _mockUserProfilePostListResponse = {
  "status": 200,
  "msg": "성공",
  "body": {
    "current": 0,
    "size": 12,
    "totalCount": 2,
    "totalPage": 1,
    "prev": 0,
    "next": 0,
    "isFirst": true,
    "isLast": false,
    "postList": [
      {
        "postId": 4,
        "postImageUrl": "https://picsum.photos/seed/ssar2_a/800/600",
      },
      {
        "postId": 3,
        "postImageUrl": "https://picsum.photos/seed/ssar1_a/800/600",
      },
    ],
  },
};

final Map<String, dynamic> _mockUserProfileStoryListResponse = {
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
    "storyList": [
      {
        "storyId": 18,
        "thumbnailUrl":
            "https://cdn.pixabay.com/video/2019/02/01/21116-315137080_tiny.jpg",
      },
      {
        "storyId": 16,
        "thumbnailUrl":
            "https://cdn.pixabay.com/video/2016/09/14/5278-182817488_tiny.jpg",
      },
      {
        "storyId": 15,
        "thumbnailUrl":
            "https://cdn.pixabay.com/video/2018/02/19/14385-256955049_tiny.jpg",
      },
      {
        "storyId": 2,
        "thumbnailUrl": "https://picsum.photos/seed/story02/400/300",
      },
    ],
  },
};
