class StoryItem {
  final String id;
  final String imageUrl;
  final String? caption;
  final DateTime createdAt;

  StoryItem({
    required this.id,
    required this.imageUrl,
    this.caption,
    required this.createdAt,
  });
}

class StoryModel {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String track;
  final bool hasStory;
  final bool isViewed;
  final DateTime? lastUpdated;
  final List<StoryItem> items;

  StoryModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.track,
    this.hasStory = false,
    this.isViewed = false,
    this.lastUpdated,
    this.items = const [],
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      userAvatar: json['userAvatar'],
      track: json['track'],
      hasStory: json['hasStory'] ?? false,
      isViewed: json['isViewed'] ?? false,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'])
          : null,
      items: (json['items'] as List<dynamic>?)
              ?.map((item) => StoryItem(
                    id: item['id'],
                    imageUrl: item['imageUrl'],
                    caption: item['caption'],
                    createdAt: DateTime.parse(item['createdAt']),
                  ))
              .toList() ??
          [],
    );
  }
}
