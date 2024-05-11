import 'package:rankai/core/http/apis.dart';
import 'package:rankai/core/http/client.dart';
import 'package:rankai/features/chat/data/models/completions/completion_model.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';

abstract class AIDataSource {
  Future<CompletionsModel> fetchRankings(List<MessageModel> messages);
}

class AIDataSourceImpl extends AIDataSource {
  final HTTP httpClient;
  AIDataSourceImpl(this.httpClient);

  @override
  Future<CompletionsModel> fetchRankings(List<MessageModel> messages) async {
    try {
      final response = await httpClient.client.post(
        APIs.completions,
        data: {
          "messages": messages.map((e) => e.toJson()).toList(),
          "n": 1,
        },
      );
      return CompletionsModel.fromJson(Map.from(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
