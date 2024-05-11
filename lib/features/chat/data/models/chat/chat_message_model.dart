class ChatMessageModel {
  int timestamp;
  String content;
  bool fromUser;

  ChatMessageModel({
    required this.timestamp,
    required this.fromUser,
    required this.content,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      timestamp: json['timestamp'],
      fromUser: json['fromUser'],
      content: json['content'],
    );
  }
}
