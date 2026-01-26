import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/post_model.dart';
import '../../../data/models/comment_model.dart';

class CommentsModal extends StatefulWidget {
  final PostModel post;

  const CommentsModal({Key? key, required this.post}) : super(key: key);

  @override
  State<CommentsModal> createState() => _CommentsModalState();
}

class _CommentsModalState extends State<CommentsModal> {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final String currentUserId = 'current_user';
  final String currentUsername = '나';
  final String currentUserAvatar = '😊';

  List<CommentModel> comments = [];

  @override
  void initState() {
    super.initState();
    _commentController.addListener(() {
      setState(() {}); // 입력창 상태 업데이트를 위해
    });
    // 샘플 댓글 데이터
    comments = [
      CommentModel(
        id: '1',
        postId: widget.post.id,
        userId: '2',
        username: 'ai_genius_lee',
        userAvatar: '🤖',
        content: '정말 멋진 프로젝트네요!',
        likesCount: 12,
        isLiked: false,
        createdAt: DateTime.now().subtract(Duration(hours: 2)),
      ),
      CommentModel(
        id: '2',
        postId: widget.post.id,
        userId: '3',
        username: 'fullstack_park',
        userAvatar: '💻',
        content: '코드 공유해주실 수 있나요?',
        likesCount: 5,
        isLiked: true,
        createdAt: DateTime.now().subtract(Duration(hours: 1)),
      ),
      CommentModel(
        id: '3',
        postId: widget.post.id,
        userId: '4',
        username: 'FISA_Official',
        userAvatar: '🎓',
        content: '훌륭한 작업입니다!',
        likesCount: 8,
        isLiked: false,
        createdAt: DateTime.now().subtract(Duration(minutes: 30)),
      ),
      CommentModel(
        id: '4',
        postId: widget.post.id,
        userId: '5',
        username: 'dev_squad',
        userAvatar: '🚀',
        content: '배포 과정도 공유해주세요!',
        likesCount: 3,
        isLiked: false,
        createdAt: DateTime.now().subtract(Duration(minutes: 15)),
      ),
    ];
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;

    setState(() {
      comments.add(
        CommentModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          postId: widget.post.id,
          userId: currentUserId,
          username: currentUsername,
          userAvatar: currentUserAvatar,
          content: _commentController.text.trim(),
          likesCount: 0,
          isLiked: false,
          createdAt: DateTime.now(),
        ),
      );
    });

    _commentController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return '방금 전';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${timestamp.month}/${timestamp.day}';
    }
  }

  void _toggleLike(CommentModel comment) {
    setState(() {
      final index = comments.indexWhere((c) => c.id == comment.id);
      if (index != -1) {
        comments[index] = CommentModel(
          id: comment.id,
          postId: comment.postId,
          userId: comment.userId,
          username: comment.username,
          userAvatar: comment.userAvatar,
          content: comment.content,
          likesCount: comment.isLiked
              ? comment.likesCount - 1
              : comment.likesCount + 1,
          isLiked: !comment.isLiked,
          createdAt: comment.createdAt,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      '댓글',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: AppTheme.textPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ],
                ),
              ),

              Divider(height: 1),

              // Comments List
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              comment.userAvatar,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.textPrimary,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: comment.username,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(text: ' '),
                                      TextSpan(text: comment.content),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Row(
                                  children: [
                                    Text(
                                      _formatTime(comment.createdAt),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    GestureDetector(
                                      onTap: () => _toggleLike(comment),
                                      child: Text(
                                        '좋아요',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.textSecondary,
                                          fontWeight: comment.isLiked
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (comment.likesCount > 0) ...[
                                      SizedBox(width: 8),
                                      Text(
                                        '${comment.likesCount}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              comment.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 18,
                              color: comment.isLiked
                                  ? Colors.red
                                  : AppTheme.textSecondary,
                            ),
                            onPressed: () => _toggleLike(comment),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              Divider(height: 1),

              // Comment Input
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SafeArea(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey[200],
                        child: Text(
                          currentUserAvatar,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _commentController,
                          decoration: InputDecoration(
                            hintText: '댓글 추가...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(color: AppTheme.primaryBlue),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _addComment(),
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        onPressed: _addComment,
                        child: Text(
                          '게시',
                          style: TextStyle(
                            color: _commentController.text.trim().isNotEmpty
                                ? AppTheme.primaryBlue
                                : AppTheme.primaryBlue.withOpacity(0.3),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void show(BuildContext context, PostModel post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CommentsModal(post: post),
    );
  }
}
