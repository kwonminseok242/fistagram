import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/story_model.dart';
import 'story_progress_bar.dart';

class StoryViewerPage extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;

  const StoryViewerPage({
    Key? key,
    required this.stories,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late int _currentStoryIndex;
  late int _currentItemIndex;
  late AnimationController _progressController;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _currentStoryIndex = widget.initialIndex;
    _currentItemIndex = 0;
    _pageController = PageController(initialPage: widget.initialIndex);
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        if (_progressController.isCompleted) {
          _nextItem();
        }
      });
    _startProgress();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _startProgress() {
    if (!_isPaused && _getCurrentStory().items.isNotEmpty) {
      _progressController.forward();
    }
  }

  void _pauseProgress() {
    _isPaused = true;
    _progressController.stop();
  }

  void _resumeProgress() {
    _isPaused = false;
    _progressController.forward();
  }

  void _nextStory() {
    if (_currentStoryIndex < widget.stories.length - 1) {
      setState(() {
        _currentStoryIndex++;
        _currentItemIndex = 0;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _progressController.reset();
      _startProgress();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _previousStory() {
    if (_currentStoryIndex > 0) {
      setState(() {
        _currentStoryIndex--;
        _currentItemIndex = 0;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _progressController.reset();
      _startProgress();
    }
  }

  void _nextItem() {
    final story = _getCurrentStory();
    if (_currentItemIndex < story.items.length - 1) {
      setState(() {
        _currentItemIndex++;
      });
      _progressController.reset();
      _startProgress();
    } else {
      _nextStory();
    }
  }

  void _previousItem() {
    if (_currentItemIndex > 0) {
      setState(() {
        _currentItemIndex--;
      });
      _progressController.reset();
      _startProgress();
    } else {
      _previousStory();
    }
  }

  StoryModel _getCurrentStory() {
    return widget.stories[_currentStoryIndex];
  }

  StoryItem? _getCurrentItem() {
    final story = _getCurrentStory();
    if (story.items.isEmpty) return null;
    return story.items[_currentItemIndex];
  }

  @override
  Widget build(BuildContext context) {
    final story = _getCurrentStory();
    final item = _getCurrentItem();

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) => _pauseProgress(),
        onTapUp: (_) => _resumeProgress(),
        onTapCancel: () => _resumeProgress(),
        child: Stack(
          children: [
            // Story Content with horizontal swipe
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentStoryIndex = index;
                  _currentItemIndex = 0;
                });
                _progressController.reset();
                _startProgress();
              },
              itemCount: widget.stories.length,
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                // 현재 스토리인 경우 현재 아이템 인덱스 사용, 아니면 첫 번째 아이템
                final itemIndex = (index == _currentStoryIndex) 
                    ? _currentItemIndex.clamp(0, story.items.length - 1)
                    : 0;
                
                if (story.items.isEmpty) {
                  return _buildEmptyStory(story);
                }
                
                return _buildStoryItem(story, story.items[itemIndex]);
              },
            ),

            // Progress Bars
            if (story.items.isNotEmpty)
              Positioned(
                top: 40,
                left: 8,
                right: 8,
                child: StoryProgressBar(
                  items: story.items,
                  currentIndex: _currentItemIndex,
                  progressController: _progressController,
                ),
              ),

            // Header
            Positioned(
              top: 60,
              left: 16,
              right: 16,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Text(
                      story.userAvatar,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          story.username,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (story.lastUpdated != null)
                          Text(
                            _formatTime(story.lastUpdated!),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Tap Areas (헤더 영역 제외)
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  // Left tap area (previous)
                  Expanded(
                    child: GestureDetector(
                      onTap: _previousItem,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                  // Right tap area (next)
                  Expanded(
                    child: GestureDetector(
                      onTap: _nextItem,
                      child: Container(color: Colors.transparent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyStory(StoryModel story) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            story.userAvatar,
            style: TextStyle(fontSize: 80),
          ),
          SizedBox(height: 16),
          Text(
            story.username,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '스토리가 없습니다',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryItem(StoryModel story, StoryItem item) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(item.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.3),
              ],
            ),
          ),
        ),
        if (item.caption != null)
          Positioned(
            bottom: 100,
            left: 16,
            right: 16,
            child: Text(
              item.caption!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(0, 1),
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }
}
