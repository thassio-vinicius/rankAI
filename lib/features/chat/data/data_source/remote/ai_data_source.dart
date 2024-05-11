import 'package:rankai/core/http/apis.dart';
import 'package:rankai/core/http/client.dart';
import 'package:rankai/features/chat/data/models/completions/completion_model.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';
import 'package:rankai/features/chat/data/models/images/generated_image_model.dart';
import 'package:rankai/features/chat/utils/gpt_model.dart';

abstract class AIDataSource {
  Future<CompletionsModel> fetchRankings(List<MessageModel> messages);
  Future<GeneratedImageModel> generateImages(String prompt);
}

class AIDataSourceImpl extends AIDataSource {
  final HTTP httpClient;
  AIDataSourceImpl(this.httpClient);

  @override
  Future<CompletionsModel> fetchRankings(List<MessageModel> messages) async {
    try {
      final response = await httpClient.client.post(
        APIs.chatCompletions,
        data: {
          "messages": messages.map((e) => e.toJson()).toList(),
          "n": 1,
          "model": GptModel.gpt35.key,
        },
      );
      return CompletionsModel.fromJson(Map.from(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<GeneratedImageModel> generateImages(String prompt) async {
    try {
      final response = await httpClient.client.post(
        APIs.imageGenerations,
        data: {
          "prompt": prompt,
          "n": 1,
          "model": GptModel.dalle3.key,
          "response_format": "b64_json"
        },
      );
      return GeneratedImageModel.fromJson(Map.from(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
