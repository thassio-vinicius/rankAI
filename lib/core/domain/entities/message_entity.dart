import 'package:equatable/equatable.dart';
import 'package:rankai/core/data/models/message_model.dart';

class MessageEntity extends Equatable {
  final String role;
  final String content;

  const MessageEntity({
    required this.role,
    required this.content,
  });

  factory MessageEntity.fromModel(MessageModel model) {
    return MessageEntity(
      role: model.role,
      content: model.content,
    );
  }

  @override
  List<Object?> get props => [role, content];
}
