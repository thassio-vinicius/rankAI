import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';
import 'package:rankai/features/chat/enums/message_role.dart';

class MessageEntity extends Equatable {
  final MessageRole role;
  final String content;

  const MessageEntity({
    required this.role,
    required this.content,
  });

  factory MessageEntity.fromModel(MessageModel model) {
    return MessageEntity(
      role: MessageRole.values.firstWhere(
          (element) => element.key == model.role,
          orElse: () => MessageRole.none),
      content: model.content,
    );
  }

  @override
  List<Object?> get props => [role, content];
}
