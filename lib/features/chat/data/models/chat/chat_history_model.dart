import 'package:rankai/features/chat/data/models/chat/chat_message_model.dart';

class ChatHistoryModel {
  List<ChatMessageModel> messages;
  int startingTimestamp;
  ChatHistoryModel({required this.messages, required this.startingTimestamp});

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    return ChatHistoryModel(
      messages: List<ChatMessageModel>.from(
          json['messages'].map((x) => ChatMessageModel.fromJson(x))),
      startingTimestamp: json['startingTimestamp'],
    );
  }
}
