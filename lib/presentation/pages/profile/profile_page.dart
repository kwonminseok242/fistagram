import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_styles.dart';
import '../../widgets/common/custom_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedTab = 0;

  final List<Map<String, dynamic>> myProjects = [
    {
      'title': '날씨 예측 AI',
      'image':
          'https://images.unsplash.com/photo-1592210454359-9043f067919b?w=300&h=300&fit=crop',
      'tech': 'AI',
    },
    {
      'title': 'AWS 인프라 구축',
      'image':
          'https://images.unsplash.com/photo-1451187580459-43490279c0fa?w=300&h=300&fit=crop',
      'tech': 'Cloud',
    },
    {
      'title': 'SNS 클론 코딩',
      'image':
          'https://images.unsplash.com/photo-1611162617474-5b21e879e113?w=300&h=300&fit=crop',
      'tech': 'Dev',
    },
    {
      'title': 'Docker 컨테이너화',
      'image':
          'https://images.unsplash.com/photo-1605745341112-85968b19335b?w=300&h=300&fit=crop',
      'tech': 'Cloud',
    },
    {
      'title': '챗봇 개발',
      'image':
          'https://images.unsplash.com/photo-1531746790731-6c087fecd65a?w=300&h=300&fit=crop',
      'tech': 'AI',
    },
    {
      'title': 'REST API 서버',
      'image':
          'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=300&h=300&fit=crop',
      'tech': 'Dev',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Profile Header
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Avatar
                  Container(
                    width: 80,
                    height: 80,
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
                    padding: EdgeInsets.all(3),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text('💻', style: TextStyle(fontSize: 36)),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  // Stats
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatColumn('${myProjects.length}', 'Projects'),
                        _buildStatColumn('234', 'Followers'),
                        _buildStatColumn('189', 'Following'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Bio
              Text('홍길동', style: AppTextStyles.h3),
              SizedBox(height: 4),
              Text('우리FISA 6기 🎓', style: AppTextStyles.bodyMedium),
              Text('클라우드 서비스 개발 과정', style: AppTextStyles.bodyMedium),
              SizedBox(height: 12),

              // Tech Stack Tags
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildTechTag('React', Colors.blue),
                  _buildTechTag('Spring Boot', Colors.green),
                  _buildTechTag('AWS', Colors.purple),
                ],
              ),
              SizedBox(height: 16),

              // Edit Profile Button
              CustomButton(
                text: 'Edit Profile',
                onPressed: () {},
                width: double.infinity,
              ),
            ],
          ),
        ),

        // Tabs
        Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[300]!)),
          ),
          child: Row(
            children: [
              _buildTab(0, Icons.grid_on),
              _buildTab(1, Icons.code),
              _buildTab(2, Icons.bookmark_border),
            ],
          ),
        ),

        // Projects Grid
        Padding(
          padding: EdgeInsets.all(1),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemCount: myProjects.length,
            itemBuilder: (context, index) {
              final project = myProjects[index];
              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(project['image'], fit: BoxFit.cover),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Text(
                        project['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(value, style: AppTextStyles.h3),
        SizedBox(height: 4),
        Text(label, style: AppTextStyles.bodySmall),
      ],
    );
  }

  Widget _buildTechTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: color.withOpacity(0.8),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTab(int index, IconData icon) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Icon(
            icon,
            color: isSelected ? AppTheme.primaryBlue : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}
