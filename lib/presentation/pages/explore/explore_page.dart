import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_styles.dart';
import '../../widgets/common/custom_text_field.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> techStacks = [
    {'name': 'AWS', 'count': 124, 'icon': '☁️'},
    {'name': 'Docker', 'count': 98, 'icon': '🐳'},
    {'name': 'Python', 'count': 156, 'icon': '🐍'},
    {'name': 'React', 'count': 143, 'icon': '⚛️'},
    {'name': 'TensorFlow', 'count': 87, 'icon': '🧠'},
    {'name': 'Spring Boot', 'count': 112, 'icon': '🍃'},
  ];

  final List<Map<String, dynamic>> suggestedUsers = [
    {
      'username': 'cloud_newbie',
      'name': '최수진',
      'track': 'Cloud Engineering',
      'avatar': '☁️',
    },
    {
      'username': 'ai_enthusiast',
      'name': '강민호',
      'track': 'AI Engineering',
      'avatar': '🤖',
    },
    {
      'username': 'backend_dev',
      'name': '윤서영',
      'track': 'Cloud Service Dev',
      'avatar': '💻',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16),
      children: [
        // Search Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomTextField(
            controller: _searchController,
            hintText: 'Search tech stacks, projects...',
            prefixIcon: Icon(Icons.search, color: AppTheme.textSecondary),
          ),
        ),
        SizedBox(height: 24),

        // Tech Stacks
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('인기 기술 스택', style: AppTextStyles.h3),
        ),
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.0,
            ),
            itemCount: techStacks.length,
            itemBuilder: (context, index) {
              final tech = techStacks[index];
              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(tech['icon'], style: TextStyle(fontSize: 28)),
                    SizedBox(height: 8),
                    Text(tech['name'], style: AppTextStyles.h3),
                    Text(
                      '${tech['count']} 게시물',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24),

        // Suggested Users
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('추천 반 친구들', style: AppTextStyles.h3),
        ),
        SizedBox(height: 12),
        ...suggestedUsers.map((user) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.lightBlue,
                        AppTheme.primaryBlue,
                        AppTheme.darkBlue,
                      ],
                    ),
                  ),
                  padding: EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        user['avatar'],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user['username'], style: AppTextStyles.username),
                      Text(
                        '${user['name']} • ${user['track']}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  child: Text('Follow', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}
