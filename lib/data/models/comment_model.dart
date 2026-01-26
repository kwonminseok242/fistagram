class CommentModel {
  final String id;
  final String postId;
  final String userId;
  final String username;
  final String userAvatar;
  final String content;
  final int likesCount;
  final bool isLiked;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.postId,
    required this.userId,
    required this.username,
    required this.userAvatar,
    required this.content,
    this.likesCount = 0,
    this.isLiked = false,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      username: json['username'],
      userAvatar: json['userAvatar'],
      content: json['content'],
      likesCount: json['likesCount'] ?? 0,
      isLiked: json['isLiked'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
