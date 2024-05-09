class MessageModel {
  String role;
  String content;

  MessageModel({
    required this.role,
    required this.content,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      role: json['role'],
      content: json['content'],
    );
  }
}
