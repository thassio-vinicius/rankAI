import 'package:dartz/dartz.dart';
import 'package:rankai/features/chat/data/data_source/remote/ai_data_source.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';
import 'package:rankai/features/chat/domain/entities/completions/completion_entity.dart';

class AIRepository {
  final AIDataSource _source;
  const AIRepository(this._source);

  Future<Either<Exception, CompletionsEntity>> fetchRankings(
      String prompt) async {
    try {
      final userMessage = MessageModel(role: 'user', content: prompt);
      final systemMessage = MessageModel(
        role: 'system',
        content:
            "You are a helpful assistant, but you only answer questions about rankings",
      );

      final response = await _source.fetchRankings([
        systemMessage,
        userMessage,
      ]);

      return Right(CompletionsEntity.fromModel(response));
    } catch (e) {
      return Left(Exception());
    }
  }
}
