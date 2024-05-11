import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/completions/usage_model.dart';

class UsageEntity extends Equatable {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  const UsageEntity({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory UsageEntity.fromModel(UsageModel model) {
    return UsageEntity(
      promptTokens: model.promptTokens,
      completionTokens: model.completionTokens,
      totalTokens: model.totalTokens,
    );
  }

  @override
  List<Object?> get props => [promptTokens, completionTokens, totalTokens];
}
