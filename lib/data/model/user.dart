class User {
  int userId;
  String username;
  String imgUrl;
  String roles;
  String? accessToken;

  User({
    required this.userId,
    required this.username,
    required this.imgUrl,
    required this.roles,
    this.accessToken,
  });

  User.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      imgUrl = data['profileImageUrl'],
      roles = data['roles'] ?? "",
      accessToken = data['accessToken'];

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, imgUrl: $imgUrl,roles: $roles, accessToken: $accessToken}';
  }
}
