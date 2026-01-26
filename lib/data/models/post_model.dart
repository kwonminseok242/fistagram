class PostModel {
  final String id;
  final String userId;
  final String username;
  final String userAvatar;
  final String userTrack;
  final String imageUrl;
  final String caption;
  final List<String> tags;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final bool isSaved;
  final DateTime createdAt;

  PostModel({
    required this.id,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.userTrack,
    required this.imageUrl,
    required this.caption,
    this.tags = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.isLiked = false,
    this.isSaved = false,
    required this.createdAt,
  });

  // JSON 변환
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      userAvatar: json['userAvatar'],
      userTrack: json['userTrack'],
      imageUrl: json['imageUrl'],
      caption: json['caption'],
      tags: List<String>.from(json['tags'] ?? []),
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      isSaved: json['isSaved'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'username': username,
      'userAvatar': userAvatar,
      'userTrack': userTrack,
      'imageUrl': imageUrl,
      'caption': caption,
      'tags': tags,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'isLiked': isLiked,
      'isSaved': isSaved,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // 복사본 생성 (상태 변경용)
  PostModel copyWith({
    bool? isLiked,
    bool? isSaved,
    int? likesCount,
    int? commentsCount,
  }) {
    return PostModel(
      id: id,
      userId: userId,
      username: username,
      userAvatar: userAvatar,
      userTrack: userTrack,
      imageUrl: imageUrl,
      caption: caption,
      tags: tags,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      createdAt: createdAt,
    );
  }
}
