import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PostActions extends StatelessWidget {
  final bool isLiked;
  final bool isSaved;
  final VoidCallback onLikeTap;
  final VoidCallback onCommentTap;
  final VoidCallback onShareTap;
  final VoidCallback onSaveTap;

  const PostActions({
    Key? key,
    required this.isLiked,
    required this.isSaved,
    required this.onLikeTap,
    required this.onCommentTap,
    required this.onShareTap,
    required this.onSaveTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? AppTheme.primaryBlue : AppTheme.textPrimary,
            ),
            onPressed: onLikeTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.chat_bubble_outline),
            onPressed: onCommentTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          SizedBox(width: 16),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: onShareTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: isSaved ? AppTheme.textPrimary : AppTheme.textPrimary,
            ),
            onPressed: onSaveTap,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
