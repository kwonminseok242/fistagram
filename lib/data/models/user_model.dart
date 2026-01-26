class UserModel {
  final String id;
  final String username;
  final String name;
  final String? bio;
  final String? profileImage;
  final String track; // 'Cloud Engineering', 'AI Engineering', etc.
  final List<String> techStacks;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.username,
    required this.name,
    this.bio,
    this.profileImage,
    required this.track,
    this.techStacks = const [],
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.isVerified = false,
  });

  // JSON 변환 (API 연동 시 사용)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      bio: json['bio'],
      profileImage: json['profileImage'],
      track: json['track'],
      techStacks: List<String>.from(json['techStacks'] ?? []),
      followersCount: json['followersCount'] ?? 0,
      followingCount: json['followingCount'] ?? 0,
      postsCount: json['postsCount'] ?? 0,
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'bio': bio,
      'profileImage': profileImage,
      'track': track,
      'techStacks': techStacks,
      'followersCount': followersCount,
      'followingCount': followingCount,
      'postsCount': postsCount,
      'isVerified': isVerified,
    };
  }
}
