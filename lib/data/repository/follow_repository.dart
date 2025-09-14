import 'package:logger/logger.dart';

class FollowRepository {
  // 팔로워 목록 조회
  Future<Map<String, dynamic>> getFollowers(int userId) async {
    try {
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
    } catch (e) {
      Logger().e("getFollowers 실패: $e");
      return {"status": 500, "msg": "통신 실패"};
    }
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
}
