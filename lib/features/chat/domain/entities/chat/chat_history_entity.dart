import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/chat/chat_history_model.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_message_entity.dart';

class ChatHistoryEntity extends Equatable {
  final List<ChatMessageEntity> messages;
  final int startingTimestamp;

  const ChatHistoryEntity({
    required this.messages,
    required this.startingTimestamp,
  });

  ChatHistoryEntity copyWith({
    int? startingTimestamp,
    List<ChatMessageEntity>? messages,
  }) {
    return ChatHistoryEntity(
      messages: messages ?? this.messages,
      startingTimestamp: startingTimestamp ?? this.startingTimestamp,
    );
  }

  factory ChatHistoryEntity.fromModel(ChatHistoryModel model) {
    return ChatHistoryEntity(
      messages: model.messages
          .map(
            (x) => ChatMessageEntity.fromModel(x),
          )
          .toList(),
      startingTimestamp: model.startingTimestamp,
    );
  }

  factory ChatHistoryEntity.fromJson(Map<String, dynamic> json) {
    return ChatHistoryEntity(
      messages: List.from(json['messages'])
          .map((e) => ChatMessageEntity.fromJson(e))
          .toList(),
      startingTimestamp: json['startingTimestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'messages': messages.map((e) => e.toJson()).toList(),
        'startingTimestamp': startingTimestamp,
      };

  @override
  List<Object?> get props => [messages, startingTimestamp];
}
