import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/completions/choice_model.dart';
import 'package:rankai/features/chat/domain/entities/completions/message_entity.dart';

class ChoiceEntity extends Equatable {
  final int index;
  final MessageEntity message;
  final bool? logprobs;
  final String finishReason;

  const ChoiceEntity({
    required this.index,
    required this.message,
    required this.finishReason,
    this.logprobs,
  });

  factory ChoiceEntity.fromModel(ChoiceModel model) {
    return ChoiceEntity(
      index: model.index,
      message: MessageEntity.fromModel(model.message),
      logprobs: model.logprobs,
      finishReason: model.finishReason,
    );
  }

  @override
  List<Object?> get props => [index, message, logprobs, finishReason];
}
