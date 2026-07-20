class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final bool isRead;
  final String typeMsg;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    this.isRead = false,
    this.typeMsg = "user"
  });
}