import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = {
      "notifications": {
        "likes": [
          {
            "user": {
              "userId": 1,
              "username": "busanlottgiants",
              "name": "롯데 자이언츠",
              "profileImageUrl": "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
              "isFollowing": false,
              "followingId": null,
            },
            "post": {
              "postId": 101,
              "postImageUrl": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
            },
            "createdAt": "2025-08-30 10:15:00",
          },
          {
            "user": {
              "userId": 2,
              "username": "user123",
              "name": "유저123",
              "profileImageUrl": "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
              "isFollowing": false,
              "followingId": null,
            },
            "post": {
              "postId": 102,
              "postImageUrl": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
            },
            "createdAt": "2025-08-30 10:15:00",
          },
        ],
        "comments": [
          {
            "user": {
              "userId": 3,
              "username": "kimseryuk",
              "name": "김세륙",
              "profileImageUrl": "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
              "isFollowing": true,
              "followingId": 3,
            },
            "post": {
              "postId": 103,
              "postImageUrl": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
            },
            "comment": "와 진짜 멋지네요!",
            "createdAt": "2025-08-30 10:15:00",
          },
          {
            "user": {
              "userId": 4,
              "username": "hannah",
              "name": "Hannah",
              "profileImageUrl": "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
              "isFollowing": false,
              "followingId": null,
            },
            "post": {
              "postId": 104,
              "postImageUrl": "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
            },
            "comment": "이건 어디서 찍으신 건가요?",
            "createdAt": "2025-08-30 10:15:00",
          },
        ],
        "follows": [
          {
            "user": {
              "userId": 5,
              "username": "kwonohyeon",
              "name": "권오현",
              "profileImageUrl": "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
              "isFollowing": true,
              "followingId": 5,
            },
            "createdAt": "2025-08-30 10:15:00",
          },
          {
            "user": {
              "userId": 6,
              "username": "new_fan",
              "name": "new fan",
              "profileImageUrl": "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
              "isFollowing": false,
              "followingId": null,
            },
            "createdAt": "2025-08-30 10:15:00",
          },
        ],
      },
    };
    return Scaffold(
      appBar: _appBar(context),
      body: NotificationBody(notifications: notifications),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios),
    ),
    title: const Text("알림"),
  );
}
