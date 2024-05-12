import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/chat/chat_message_model.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';
import 'package:rankai/features/chat/enums/message_role.dart';

class ChatMessageEntity extends Equatable {
  final String content;
  final int timestamp;
  final bool fromUser;
  final String? image;

  const ChatMessageEntity({
    required this.fromUser,
    required this.content,
    required this.timestamp,
    this.image,
  });

  Uint8List? toUint8List() {
    return image == null ? null : base64Decode(image!);
  }

  factory ChatMessageEntity.fromModel(ChatMessageModel model) {
    return ChatMessageEntity(
      fromUser: model.fromUser,
      content: model.content,
      timestamp: model.timestamp,
      image: model.image,
    );
  }

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json) {
    return ChatMessageEntity(
      fromUser: json['fromUser'],
      content: json['content'],
      timestamp: json['timestamp'],
      image: json['image'],
    );
  }

  MessageModel toModel() => MessageModel(
        role: fromUser ? MessageRole.user.key : MessageRole.assistant.key,
        content: content,
      );

  Map<String, dynamic> toJson() => {
        'fromUser': fromUser,
        'content': content,
        'timestamp': timestamp,
        'image': image,
      };

  @override
  List<Object?> get props => [
        content,
        timestamp,
        fromUser,
        image,
      ];
}
