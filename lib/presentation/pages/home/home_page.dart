import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/story_model.dart';
import '../../providers/post_providerr.dart';
import '../../widgets/story/story_list.dart';
import '../../widgets/post/post_card.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<StoryModel> stories = [
    StoryModel(
      id: '1',
      userId: '1',
      username: 'My Story',
      userAvatar: '😊',
      track: 'Cloud Service Dev',
      hasStory: false,
    ),
    StoryModel(
      id: '2',
      userId: '2',
      username: 'FISA_Official',
      userAvatar: '🎓',
      track: 'Official',
      hasStory: true,
      items: [
        StoryItem(
          id: '2-1',
          imageUrl:
              'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800&h=1200&fit=crop',
          caption: 'FISA 공식 스토리입니다! 🎓',
          createdAt: DateTime.now().subtract(Duration(hours: 2)),
        ),
        StoryItem(
          id: '2-2',
          imageUrl:
              'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800&h=1200&fit=crop',
          caption: '새로운 프로젝트 공유',
          createdAt: DateTime.now().subtract(Duration(hours: 1)),
        ),
      ],
      lastUpdated: DateTime.now().subtract(Duration(hours: 1)),
    ),
    StoryModel(
      id: '3',
      userId: '3',
      username: 'cloud_team',
      userAvatar: '☁️',
      track: 'Cloud Engineering',
      hasStory: true,
      items: [
        StoryItem(
          id: '3-1',
          imageUrl:
              'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=800&h=1200&fit=crop',
          caption: 'AWS 클라우드 아키텍처 설계 완료! ☁️',
          createdAt: DateTime.now().subtract(Duration(hours: 3)),
        ),
      ],
      lastUpdated: DateTime.now().subtract(Duration(hours: 3)),
    ),
    StoryModel(
      id: '4',
      userId: '4',
      username: 'ai_study',
      userAvatar: '🤖',
      track: 'AI Engineering',
      hasStory: true,
      items: [
        StoryItem(
          id: '4-1',
          imageUrl:
              'https://images.unsplash.com/photo-1555949963-aa79dcee981c?w=800&h=1200&fit=crop',
          caption: '머신러닝 모델 학습 중... 🤖',
          createdAt: DateTime.now().subtract(Duration(hours: 5)),
        ),
        StoryItem(
          id: '4-2',
          imageUrl:
              'https://images.unsplash.com/photo-1485827404703-89b55fcc595e?w=800&h=1200&fit=crop',
          caption: '데이터 분석 결과 공유',
          createdAt: DateTime.now().subtract(Duration(hours: 4)),
        ),
      ],
      lastUpdated: DateTime.now().subtract(Duration(hours: 4)),
    ),
    StoryModel(
      id: '5',
      userId: '5',
      username: 'dev_squad',
      userAvatar: '💻',
      track: 'Cloud Service Dev',
      hasStory: true,
      items: [
        StoryItem(
          id: '5-1',
          imageUrl:
              'https://images.unsplash.com/photo-1537432376769-00f5c2f4c8d2?w=800&h=1200&fit=crop',
          caption: '프로젝트 데모 준비 중 💻',
          createdAt: DateTime.now().subtract(Duration(hours: 6)),
        ),
      ],
      lastUpdated: DateTime.now().subtract(Duration(hours: 6)),
    ),
  ];

  final List<Map<String, dynamic>> tracks = [
    {'id': 'all', 'name': '전체', 'icon': '🎯', 'color': AppTheme.primaryBlue},
    {
      'id': 'cloud-eng',
      'name': '클라우드 엔지니어링',
      'icon': '☁️',
      'color': Color(0xFF0EA5E9),
    },
    {
      'id': 'ai-eng',
      'name': 'AI 엔지니어링',
      'icon': '🤖',
      'color': Color(0xFFA855F7),
    },
    {
      'id': 'cloud-dev',
      'name': '클라우드 서비스 개발',
      'icon': '💻',
      'color': Color(0xFF22C55E),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Stories
        StoryList(stories: stories),

        // Track Filter
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Consumer<PostProvider>(
            builder: (context, provider, child) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: tracks.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  final isSelected = provider.selectedTrack == track['id'];

                  return GestureDetector(
                    onTap: () => provider.setSelectedTrack(track['id']),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? track['color'] : Colors.grey[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text(track['icon'], style: TextStyle(fontSize: 16)),
                          SizedBox(width: 6),
                          Text(
                            track['name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        // Feed
        Expanded(
          child: Consumer<PostProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                itemCount: provider.filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = provider.filteredPosts[index];
                  return PostCard(
                    post: post,
                    onLikeTap: () => provider.toggleLike(post.id),
                    onSaveTap: () => provider.toggleSave(post.id),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
