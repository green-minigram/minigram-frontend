class User {
  int userId;
  String username;
  String roles;
  String? accessToken;

  User({
    required this.userId,
    required this.username,
    required this.roles,
    this.accessToken,
  });

  User.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      roles = data['roles'],
      accessToken = data['accessToken'];

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, roles: $roles, accessToken: $accessToken}';
  }
}
