import 'package:dio/dio.dart';

final baseUrl = "http://192.168.0.121:8080"; //TODO
// final baseUrl = "http://172.30.1.6:8080";

//로그인 되면, dio에 jwt 추가하기
//dio.options.headers['Authorization'] = 'Bearer $_accessToken';
final dio = Dio(
  BaseOptions(
    baseUrl: baseUrl, // 내 IP 입력
    contentType: "application/json; charset=utf-8",
    validateStatus: (status) =>
        true, // 200 이 아니어도 예외 발생안하게 설정 // 그냥 예외 터지면 dio 가 잡아서 처리함
  ),
);
