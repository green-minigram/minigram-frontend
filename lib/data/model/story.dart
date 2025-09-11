class Story {
  final int storyId;
  final String videoUrl;
  final String thumbnailUrl;
  final String createdAt; // String 으로

  Story({
    required this.storyId,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.createdAt,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      storyId: map["storyId"],
      videoUrl: map["videoUrl"],
      thumbnailUrl: map["thumbnailUrl"],
      createdAt: map["createdAt"],
    );
  }

  @override
  String toString() {
    return 'Story(storyId: $storyId, videoUrl: $videoUrl, thumbnailUrl: $thumbnailUrl, createdAt: $createdAt)';
  }
}
