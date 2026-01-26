import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_styles.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> learningActivities = [
    {
      'username': 'cloud_master_kim',
      'action': '알고리즘 문제 5개 해결',
      'time': '1h',
      'avatar': '☁️',
      'track': 'Cloud Engineering',
    },
    {
      'username': 'ai_genius_lee',
      'action': '머신러닝 프로젝트 완료',
      'time': '3h',
      'avatar': '🤖',
      'track': 'AI Engineering',
    },
    {
      'username': 'fullstack_park',
      'action': '코드 리뷰 요청',
      'time': '5h',
      'avatar': '💻',
      'track': 'Cloud Service Dev',
    },
    {
      'username': 'data_analyst_choi',
      'action': '스터디 자료 공유',
      'time': '1d',
      'avatar': '📊',
      'track': 'AI Engineering',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        // Title
        Row(
          children: [
            Icon(Icons.emoji_events, color: Colors.amber, size: 24),
            SizedBox(width: 8),
            Text('학습 활동', style: AppTextStyles.h2),
          ],
        ),
        SizedBox(height: 16),

        // Learning Activities
        ...learningActivities.map((activity) {
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              borderRadius: BorderRadius.circular(12),
            ),
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
                        activity['avatar'],
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
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.bodyMedium,
                          children: [
                            TextSpan(
                              text: activity['username'],
                              style: AppTextStyles.username,
                            ),
                            TextSpan(text: ' ${activity['action']}'),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${activity['track']} • ${activity['time']}',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.code, color: AppTheme.primaryBlue),
              ],
            ),
          );
        }).toList(),

        SizedBox(height: 24),

        // Today's Statistics
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.primaryBlue, AppTheme.darkBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '오늘의 학습 통계',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('5', '문제 풀이'),
                  _buildStatItem('2', '프로젝트'),
                  _buildStatItem('8', '커밋'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.9)),
        ),
      ],
    );
  }
}
