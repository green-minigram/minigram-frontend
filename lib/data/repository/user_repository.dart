import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minigram/_core/util/my_http.dart';

/// 책임 -> 통신 & 파싱(body data)
class UserRepository {
  Future<Map<String, dynamic>> join(String username, String email, String password) async {
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

  Future<Map<String, dynamic>> login(String username, String password) async {
    // final requestBody = {
    //   "username": username,
    //   "password": password,
    // };
    //
    // Response response = await dio.post("/login", data: requestBody);
    // Map<String, dynamic> responseBody = response.data;
    // Logger().d(responseBody);
    // return responseBody;

    // 1. 통신 코드
    final response = await Future.delayed(
      Duration(seconds: 2),
      () {
        return _mockLoginResponse;
      },
    );

    // 2. 리턴
    return response;
  }

  Future<Map<String, dynamic>> autoLogin(String accessToken) async {
    Response response = await dio.post("/auto/login", options: Options(headers: {"Authorization": accessToken}));
    Map<String, dynamic> responseBody = response.data;
    Logger().d(responseBody);
    return responseBody;
  }

  // 추가: 아이디 중복 확인
  Future<bool> checkUsernameAvailable(String username) async {
    // // 백엔드 엔드포인트에 맞게 수정
    // final Response res = await dio.get("/check/username", queryParameters: {"username": username});
    // final data = res.data as Map<String, dynamic>;
    // // 예: { success: true, response: { available: true } }
    // final available = (data["response"]?["available"]) == true;
    return true;
  }

  // 추가: 이메일 중복 확인
  Future<bool> checkEmailAvailable(String email) async {
    // final Response res = await dio.get("/check/email", queryParameters: {"email": email});
    // final data = res.data as Map<String, dynamic>;
    // final available = (data["response"]?["available"]) == true;
    return true;
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
