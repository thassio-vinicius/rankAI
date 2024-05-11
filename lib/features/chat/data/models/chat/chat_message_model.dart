class ChatMessageModel {
  int timestamp;
  String content;
  bool fromUser;
  String? image;

  ChatMessageModel({
    required this.timestamp,
    required this.fromUser,
    required this.content,
    this.image,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      timestamp: json['timestamp'],
      fromUser: json['fromUser'],
      content: json['content'],
      image: json['image'],
    );
  }
}
