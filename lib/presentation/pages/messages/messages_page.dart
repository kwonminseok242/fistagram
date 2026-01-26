import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/message_model.dart';
import 'chat_page.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({Key? key}) : super(key: key);

  final List<ChatModel> chats = [
    ChatModel(
      id: '1',
      userId: '1',
      username: 'cloud_master_kim',
      userAvatar: '☁️',
      lastMessage: '안녕하세요! 프로젝트 잘 진행되고 있나요?',
      lastMessageTime: DateTime(2026, 1, 26, 14, 30),
      unreadCount: 2,
      isOnline: true,
    ),
    ChatModel(
      id: '2',
      userId: '2',
      username: 'ai_genius_lee',
      userAvatar: '🤖',
      lastMessage: '모델 학습 결과 공유해드릴게요!',
      lastMessageTime: DateTime(2026, 1, 26, 12, 15),
      unreadCount: 0,
      isOnline: false,
    ),
    ChatModel(
      id: '3',
      userId: '3',
      username: 'fullstack_park',
      userAvatar: '💻',
      lastMessage: '코드 리뷰 부탁드립니다',
      lastMessageTime: DateTime(2026, 1, 25, 18, 45),
      unreadCount: 1,
      isOnline: true,
    ),
    ChatModel(
      id: '4',
      userId: '4',
      username: 'FISA_Official',
      userAvatar: '🎓',
      lastMessage: '새로운 공지사항이 있습니다',
      lastMessageTime: DateTime(2026, 1, 24, 10, 20),
      unreadCount: 0,
      isOnline: false,
    ),
    ChatModel(
      id: '5',
      userId: '5',
      username: 'dev_squad',
      userAvatar: '🚀',
      lastMessage: '다음 미팅 일정 확인해주세요',
      lastMessageTime: DateTime(2026, 1, 23, 16, 30),
      unreadCount: 3,
      isOnline: true,
    ),
  ];

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else {
      return '${dateTime.month}/${dateTime.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '메시지',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.edit_outlined, color: AppTheme.textPrimary),
            onPressed: () {
              // 새 메시지 작성
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.grey[200],
                  child: Text(
                    chat.userAvatar,
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    chat.username,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: chat.unreadCount > 0
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                Text(
                  _formatTime(chat.lastMessageTime),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      chat.lastMessage ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: chat.unreadCount > 0
                            ? AppTheme.textPrimary
                            : AppTheme.textSecondary,
                        fontWeight: chat.unreadCount > 0
                            ? FontWeight.w500
                            : FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (chat.unreadCount > 0)
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${chat.unreadCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChatPage(chat: chat),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
