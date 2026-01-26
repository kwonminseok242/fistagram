import 'package:flutter/material.dart';
import '../../../data/models/story_model.dart';
import '../../pages/story/story_viewer_page.dart';
import 'story_circle.dart';

class StoryList extends StatelessWidget {
  final List<StoryModel> stories;

  const StoryList({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        separatorBuilder: (context, index) => SizedBox(width: 16),
        itemBuilder: (context, index) {
          final story = stories[index];
          return StoryCircle(
            story: story,
            onTap: story.hasStory
                ? () {
                    final storiesWithContent = stories
                        .where((s) => s.hasStory && s.items.isNotEmpty)
                        .toList();
                    final initialIndex = storiesWithContent
                        .indexWhere((s) => s.id == story.id);
                    if (initialIndex != -1) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => StoryViewerPage(
                            stories: storiesWithContent,
                            initialIndex: initialIndex,
                          ),
                        ),
                      );
                    }
                  }
                : null,
          );
        },
      ),
    );
  }
}
