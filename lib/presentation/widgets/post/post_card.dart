import 'package:flutter/material.dart';
import '../../../data/models/post_model.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/text_styles.dart';
import 'post_header.dart';
import 'post_actions.dart';
import 'comments_modal.dart';

class PostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLikeTap;
  final VoidCallback onSaveTap;

  const PostCard({
    Key? key,
    required this.post,
    required this.onLikeTap,
    required this.onSaveTap,
  }) : super(key: key);

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          PostHeader(post: post),

          // Image
          Image.network(
            post.imageUrl,
            width: double.infinity,
            height: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),

          // Actions
          PostActions(
            isLiked: post.isLiked,
            isSaved: post.isSaved,
            onLikeTap: onLikeTap,
            onCommentTap: () {},
            onShareTap: () {},
            onSaveTap: onSaveTap,
          ),

          // Likes count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('${post.likesCount} likes', style: AppTextStyles.h3),
          ),
          SizedBox(height: 8),

          // Caption
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: RichText(
              text: TextSpan(
                style: AppTextStyles.bodyMedium,
                children: [
                  TextSpan(text: post.username, style: AppTextStyles.username),
                  TextSpan(text: ' '),
                  TextSpan(text: post.caption),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),

          // Tags
          if (post.tags.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 8,
                children: post.tags.map((tag) {
                  return Text(
                    tag,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
              ),
            ),
          SizedBox(height: 8),

          // Comments
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'View all ${post.commentsCount} comments',
              style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
            ),
          ),
          SizedBox(height: 4),

          // Time
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${_getTimeAgo(post.createdAt)} ago',
              style: TextStyle(fontSize: 10, color: AppTheme.textTertiary),
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
