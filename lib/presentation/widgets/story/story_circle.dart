import 'package:flutter/material.dart';
import '../../../data/models/story_model.dart';
import '../../../core/theme/app_theme.dart';

class StoryCircle extends StatelessWidget {
  final StoryModel story;
  final VoidCallback? onTap;

  const StoryCircle({Key? key, required this.story, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: story.hasStory && !story.isViewed
                  ? LinearGradient(
                      colors: [
                        AppTheme.lightBlue,
                        AppTheme.primaryBlue,
                        AppTheme.darkBlue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              color: story.hasStory ? null : Colors.grey[300],
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(story.userAvatar, style: TextStyle(fontSize: 24)),
              ),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              story.username,
              style: TextStyle(fontSize: 10, color: AppTheme.textPrimary),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
