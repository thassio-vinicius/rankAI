import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/chat/chat_message_model.dart';

class ChatMessageEntity extends Equatable {
  final String content;
  final int timestamp;
  final bool fromUser;

  const ChatMessageEntity({
    required this.fromUser,
    required this.content,
    required this.timestamp,
  });

  factory ChatMessageEntity.fromModel(ChatMessageModel model) {
    return ChatMessageEntity(
      fromUser: model.fromUser,
      content: model.content,
      timestamp: model.timestamp,
    );
  }

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      fromUser: json['fromUser'],
      content: json['content'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'fromUser': fromUser,
        'content': content,
        'timestamp': timestamp,
      };

  @override
  List<Object?> get props => [content, timestamp, fromUser];
}
