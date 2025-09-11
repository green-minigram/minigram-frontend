class User {
  int userId;
  String username;
  String? profileImageUrl;
  String roles;
  String? accessToken;

  User({
    required this.userId,
    required this.username,
    required this.roles,
    this.profileImageUrl,
    this.accessToken,
  });

  User.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      roles = data['roles'],
      profileImageUrl = data['profileImageUrl'] ?? "",
      accessToken = data['accessToken'] ?? "";

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, profileImageUrl: $profileImageUrl,roles: $roles, accessToken: $accessToken}';
  }
}
