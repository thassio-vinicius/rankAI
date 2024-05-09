import 'package:rankai/core/data/models/choice_model.dart';
import 'package:rankai/core/data/models/usage_model.dart';

class CompletionsModel {
  String id;
  String object;
  int created;
  String model;
  String systemFingerprint;
  List<ChoiceModel> choices;
  UsageModel usage;

  CompletionsModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.systemFingerprint,
    required this.choices,
    required this.usage,
  });

  factory CompletionsModel.fromJson(Map<String, dynamic> json) {
    return CompletionsModel(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      systemFingerprint: json['system_fingerprint'],
      choices: List<ChoiceModel>.from(
          json['choices'].map((x) => ChoiceModel.fromJson(x))),
      usage: UsageModel.fromJson(json['usage']),
    );
  }
}
