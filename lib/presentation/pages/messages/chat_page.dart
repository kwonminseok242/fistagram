import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/message_model.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chat;

  const ChatPage({Key? key, required this.chat}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final String currentUserId = 'current_user'; // 현재 사용자 ID

  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    // 샘플 메시지 데이터
    messages = [
      MessageModel(
        id: '1',
        senderId: widget.chat.userId,
        senderName: widget.chat.username,
        senderAvatar: widget.chat.userAvatar,
        content: '안녕하세요!',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        isRead: true,
      ),
      MessageModel(
        id: '2',
        senderId: currentUserId,
        senderName: '나',
        senderAvatar: '😊',
        content: '네, 안녕하세요!',
        timestamp: DateTime.now().subtract(Duration(hours: 2, minutes: 5)),
        isRead: true,
      ),
      MessageModel(
        id: '3',
        senderId: widget.chat.userId,
        senderName: widget.chat.username,
        senderAvatar: widget.chat.userAvatar,
        content: '프로젝트 잘 진행되고 있나요?',
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 30)),
        isRead: true,
      ),
      MessageModel(
        id: '4',
        senderId: currentUserId,
        senderName: '나',
        senderAvatar: '😊',
        content: '네, 잘 되고 있어요!',
        timestamp: DateTime.now().subtract(Duration(hours: 1, minutes: 25)),
        isRead: true,
      ),
      MessageModel(
        id: '5',
        senderId: widget.chat.userId,
        senderName: widget.chat.username,
        senderAvatar: widget.chat.userAvatar,
        content: widget.chat.lastMessage ?? '',
        timestamp: widget.chat.lastMessageTime ?? DateTime.now(),
        isRead: false,
      ),
    ];
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        MessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          senderId: currentUserId,
          senderName: '나',
          senderAvatar: '😊',
          content: _messageController.text.trim(),
          timestamp: DateTime.now(),
          isRead: true,
        ),
      );
    });

    _messageController.clear();
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

    if (difference.inDays == 0) {
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '어제 ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else {
      return '${timestamp.month}/${timestamp.day} ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    }
  }

  bool _isSameSender(int index) {
    if (index == 0) return false;
    return messages[index].senderId == messages[index - 1].senderId;
  }

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = (message) => message.senderId == currentUserId;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    widget.chat.userAvatar,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                if (widget.chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.username,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  if (widget.chat.isOnline)
                    Text(
                      '온라인',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_outlined, color: AppTheme.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.call_outlined, color: AppTheme.textPrimary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: AppTheme.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isMe = isCurrentUser(message);
                final showAvatar = !_isSameSender(index);

                return Padding(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment:
                        isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (!isMe && showAvatar)
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.grey[200],
                            child: Text(
                              message.senderAvatar,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        )
                      else if (!isMe)
                        SizedBox(width: 38),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isMe
                                ? AppTheme.primaryBlue
                                : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18),
                              bottomLeft: Radius.circular(isMe ? 18 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 18),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.content,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: isMe ? Colors.white : AppTheme.textPrimary,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _formatTime(message.timestamp),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isMe
                                          ? Colors.white70
                                          : AppTheme.textSecondary,
                                    ),
                                  ),
                                  if (isMe) ...[
                                    SizedBox(width: 4),
                                    Icon(
                                      message.isRead
                                          ? Icons.done_all
                                          : Icons.done,
                                      size: 14,
                                      color: message.isRead
                                          ? Colors.blue[200]
                                          : Colors.white70,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (isMe) SizedBox(width: 8),
                    ],
                  ),
                );
              },
            ),
          ),

          // Message Input
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_outline,
                        color: AppTheme.primaryBlue),
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: '메시지 입력...',
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
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(Icons.emoji_emotions_outlined,
                        color: AppTheme.primaryBlue),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: AppTheme.primaryBlue),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
