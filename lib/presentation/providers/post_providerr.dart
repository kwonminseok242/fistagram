import 'package:flutter/material.dart';
import '../../data/models/post_model.dart';

class PostProvider extends ChangeNotifier {
  final List<PostModel> _posts = [
    PostModel(
      id: '1',
      userId: '1',
      username: 'cloud_master_kim',
      userAvatar: '☁️',
      userTrack: 'Cloud Engineering',
      imageUrl:
          'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=500&h=500&fit=crop',
      caption: 'AWS EC2 배포 성공! 🎉 Docker 컨테이너로 마이크로서비스 아키텍처 구현했습니다.',
      tags: ['#AWS', '#Docker', '#Kubernetes'],
      likesCount: 234,
      commentsCount: 45,
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
    ),
    PostModel(
      id: '2',
      userId: '2',
      username: 'ai_genius_lee',
      userAvatar: '🤖',
      userTrack: 'AI Engineering',
      imageUrl:
          'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=500&h=500&fit=crop',
      caption: '첫 딥러닝 모델 완성! 이미지 분류 정확도 95% 달성 🔥 TensorFlow 너무 재밌어요',
      tags: ['#TensorFlow', '#DeepLearning', '#Python'],
      likesCount: 189,
      commentsCount: 32,
      createdAt: DateTime.now().subtract(Duration(hours: 5)),
    ),
    PostModel(
      id: '3',
      userId: '3',
      username: 'fullstack_park',
      userAvatar: '💻',
      userTrack: 'Cloud Service Dev',
      imageUrl:
          'https://images.unsplash.com/photo-1537432376769-00f5c2f4c8d2?w=500&h=500&fit=crop',
      caption: 'React + Spring Boot로 만든 첫 프로젝트! API 연동 성공했습니다 ✨',
      tags: ['#React', '#SpringBoot', '#RESTAPI'],
      likesCount: 312,
      commentsCount: 58,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  String _selectedTrack = 'all';

  List<PostModel> get posts => _posts;
  String get selectedTrack => _selectedTrack;

  List<PostModel> get filteredPosts {
    if (_selectedTrack == 'all') return _posts;

    return _posts.where((post) {
      if (_selectedTrack == 'cloud-eng')
        return post.userTrack == 'Cloud Engineering';
      if (_selectedTrack == 'ai-eng') return post.userTrack == 'AI Engineering';
      if (_selectedTrack == 'cloud-dev')
        return post.userTrack == 'Cloud Service Dev';
      return true;
    }).toList();
  }

  void setSelectedTrack(String track) {
    _selectedTrack = track;
    notifyListeners();
  }

  void toggleLike(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(
        isLiked: !post.isLiked,
        likesCount: post.isLiked ? post.likesCount - 1 : post.likesCount + 1,
      );
      notifyListeners();
    }
  }

  void toggleSave(String postId) {
    final index = _posts.indexWhere((post) => post.id == postId);
    if (index != -1) {
      final post = _posts[index];
      _posts[index] = post.copyWith(isSaved: !post.isSaved);
      notifyListeners();
    }
  }
}
