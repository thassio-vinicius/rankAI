import 'package:rankai/core/data/models/completion_model.dart';
import 'package:rankai/core/http/apis.dart';
import 'package:rankai/core/http/client.dart';

abstract class AIDataSource {
  Future<CompletionsModel> fetchRankings(String prompt);
}

class AIDataSourceImpl extends AIDataSource {
  final HTTP httpClient;
  AIDataSourceImpl(this.httpClient);

  @override
  Future<CompletionsModel> fetchRankings(String prompt) async {
    try {
      final response = await httpClient.client.post(
        APIs.completions,
        data: {"prompt": prompt},
      );

      return CompletionsModel.fromJson(Map.from(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
