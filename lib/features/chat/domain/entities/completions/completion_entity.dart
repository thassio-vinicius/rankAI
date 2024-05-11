import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/data/models/completions/completion_model.dart';
import 'package:rankai/features/chat/domain/entities/completions/choice_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/usage_entity.dart';

class CompletionsEntity extends Equatable {
  final String id;
  final String object;
  final int created;
  final String model;
  final String? systemFingerprint;
  final List<ChoiceEntity> choices;
  final UsageEntity usage;

  const CompletionsEntity({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
    this.systemFingerprint,
  });

  factory CompletionsEntity.fromModel(CompletionsModel model) {
    return CompletionsEntity(
      id: model.id,
      object: model.object,
      created: model.created,
      model: model.model,
      systemFingerprint: model.systemFingerprint,
      choices: model.choices
          .map((choice) => ChoiceEntity.fromModel(choice))
          .toList(),
      usage: UsageEntity.fromModel(model.usage),
    );
  }

  @override
  List<Object?> get props => [
        id,
        object,
        created,
        model,
        systemFingerprint,
        choices,
        usage,
      ];
}
