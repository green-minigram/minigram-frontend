class User {
  int id;
  String username;
  String imgUrl;
  String? accessToken;

  User({
    required this.id,
    required this.username,
    required this.imgUrl,
    this.accessToken,
  });

  User.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        imgUrl = data['imgUrl'],
        accessToken = data['accessToken'];

  @override
  String toString() {
    return 'User(id: $id, username: $username, imgUrl: $imgUrl, accessToken: $accessToken)';
  }
}
