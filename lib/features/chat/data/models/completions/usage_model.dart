class UsageModel {
  int promptTokens;
  int completionTokens;
  int totalTokens;

  UsageModel({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory UsageModel.fromJson(Map<String, dynamic> json) {
    return UsageModel(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}
