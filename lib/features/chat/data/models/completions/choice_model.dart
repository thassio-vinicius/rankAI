import 'package:rankai/features/chat/data/models/completions/message_model.dart';

class ChoiceModel {
  int index;
  MessageModel message;
  bool? logprobs;
  String finishReason;

  ChoiceModel({
    required this.index,
    required this.message,
    required this.logprobs,
    required this.finishReason,
  });

  factory ChoiceModel.fromJson(Map<String, dynamic> json) {
    return ChoiceModel(
      index: json['index'],
      message: MessageModel.fromJson(json['message']),
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'],
    );
  }
}
