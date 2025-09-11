class User {
  int userId;
  String username;
  String imgUrl;
  String? accessToken;

  User({
    required this.userId,
    required this.username,
    required this.imgUrl,
    this.accessToken,
  });

  User.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      imgUrl = data['profileImageUrl'],
      accessToken = data['accessToken'];

  @override
  String toString() {
    return 'User(userId: $userId, username: $username, imgUrl: $imgUrl, accessToken: $accessToken)';
  }
}
