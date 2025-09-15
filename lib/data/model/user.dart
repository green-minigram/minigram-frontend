class User {
  int userId;
  String username;
  String? profileImageUrl;
  String? roles;
  String? accessToken;
  bool? isFollowing;

  User({
    required this.userId,
    required this.username,
    this.roles,
    this.profileImageUrl,
    this.accessToken,
    this.isFollowing,
  });

  User.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      roles = data['roles'] ?? "",
      profileImageUrl = data['profileImageUrl'] ?? "",
      isFollowing = data['isFollowing'] ?? false,
      accessToken = data['accessToken'] ?? "";

  @override
  String toString() {
    return 'User{userId: $userId, username: $username, profileImageUrl: $profileImageUrl,roles: $roles, accessToken: $accessToken}';
  }
}
