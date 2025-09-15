import 'package:logger/logger.dart';

class FollowRepository {
  // 팔로워 목록 조회
  Future<Map<String, dynamic>> getFollowers(int userId) async {
    // final response = await dio.get("/s/api/users/$userId/followers");
    // final responseBody = response.data;
    final responseBody = {
      "status": 200,
      "msg": "성공",
      "body": {
        "userList": [
          {
            "userId": 8,
            "username": "luna",
            "name": "루나",
            "profileImageUrl": null,
            "isFollowing": true,
            "isMe": false,
          },
          {
            "userId": 9,
            "username": "zero",
            "name": "제로",
            "profileImageUrl": "https://picsum.photos/seed/zero/200",
            "isFollowing": false,
            "isMe": false,
          },
          {
            "userId": 7,
            "username": "neo",
            "name": "네오",
            "profileImageUrl": null,
            "isFollowing": false,
            "isMe": false,
          },
          {
            "userId": 2,
            "username": "ssar",
            "name": "쌀",
            "profileImageUrl": "https://picsum.photos/seed/ssar/200",
            "isFollowing": false,
            "isMe": true,
          },
        ],
      },
    };
    return responseBody;
  }

  // 팔로잉 목록 조회
  Future<Map<String, dynamic>> getFollowing(int userId) async {
    try {
      // final response = await dio.get("/s/api/users/$userId/following");
      // final responseBody = response.data;
      final responseBody = {
        "status": 200,
        "msg": "성공",
        "body": {
          "userList": [
            {
              "userId": 7,
              "username": "neo",
              "name": "네오",
              "profileImageUrl": null,
              "isFollowing": false,
              "isMe": false,
            },
            {
              "userId": 6,
              "username": "hana",
              "name": "하나",
              "profileImageUrl": "https://picsum.photos/seed/hana/200",
              "isFollowing": false,
              "isMe": false,
            },
            {
              "userId": 8,
              "username": "luna",
              "name": "루나",
              "profileImageUrl": null,
              "isFollowing": true,
              "isMe": false,
            },
          ],
        },
      };
      return responseBody;
    } catch (e) {
      Logger().e("getFollowing 실패: $e");
      return {"status": 500, "msg": "통신 실패"};
    }
  }

  // 팔로우 등록
  Future<Map<String, dynamic>> follow(int userId) async {
    // final response = await dio.post("/s/api/users/$userId/follow");
    // return response.data;

    // Mock
    return {
      "status": 200,
      "msg": "성공",
      "body": {"followId": 29, "followerId": 2, "followeeId": userId},
    };
  }

  // 팔로우 취소
  Future<Map<String, dynamic>> unfollow(int userId) async {
    // final response = await dio.delete("/s/api/users/$userId/follow");
    // return response.data;

    // Mock
    return {
      "status": 200,
      "msg": "성공",
      "body": {"followeeId": userId, "message": "해당 유저에 대한 팔로우를 취소했습니다"},
    };
  }
}
