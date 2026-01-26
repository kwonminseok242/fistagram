import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_styles.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;
  final VoidCallback? onMoreTap;

  const PostHeader({Key? key, required this.post, this.onMoreTap})
    : super(key: key);

  Color _getTrackColor() {
    switch (post.userTrack) {
      case 'Cloud Engineering':
        return Color(0xFF0EA5E9); // sky-500
      case 'AI Engineering':
        return Color(0xFFA855F7); // purple-500
      case 'Cloud Service Dev':
        return Color(0xFF22C55E); // green-500
      default:
        return AppTheme.primaryBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppTheme.lightBlue,
                  AppTheme.primaryBlue,
                  AppTheme.darkBlue,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(post.userAvatar, style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
          SizedBox(width: 12),
          // Username and Track
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.username, style: AppTextStyles.username),
                SizedBox(height: 2),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getTrackColor(),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    post.userTrack,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // More button
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: onMoreTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
