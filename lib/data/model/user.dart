class User {
  int userId;
  String username;
  String? profileImageUrl;
  String? roles;
  String? accessToken;
  bool? isFollowing;
  bool? showFollowButton;

  User({
    required this.userId,
    required this.username,
    this.roles,
    this.profileImageUrl,
    this.accessToken,
    this.isFollowing,
    this.showFollowButton,
  });

  User.fromMap(Map<String, dynamic> data)
    : userId = data['userId'],
      username = data['username'],
      roles = data['roles'] ?? "",
      profileImageUrl = data['profileImageUrl'] ?? "",
      isFollowing = data['isFollowing'] as bool?,
      showFollowButton = (data['isFollowing'] == null)
          ? null
          : !((data['isFollowing'] as bool)),
      accessToken = data['accessToken'] ?? "";

  @override
  String toString() {
    return 'User(userId: $userId, username: $username, roles: $roles, profileImageUrl: $profileImageUrl, accessToken: $accessToken, isFollowing: $isFollowing, initialFollowingState: $showFollowButton)';
  }

  User copyWith({
    int? userId,
    String? username,
    String? profileImageUrl,
    String? roles,
    String? accessToken,
    bool? isFollowing,
    bool? showFollowButton,
  }) {
    return User(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      roles: roles ?? this.roles,
      accessToken: accessToken ?? this.accessToken,
      isFollowing: isFollowing ?? this.isFollowing,
      showFollowButton: showFollowButton ?? this.showFollowButton,
    );
  }
}
