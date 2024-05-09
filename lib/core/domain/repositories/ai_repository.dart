import 'package:dartz/dartz.dart';
import 'package:rankai/core/data/data_source/ai_data_source.dart';
import 'package:rankai/core/domain/entities/completion_entity.dart';

class AIRepository {
  final AIDataSource source;
  const AIRepository(this.source);

  Future<Either<Exception, CompletionsEntity>> fetchRankings(
      String prompt) async {
    try {
      final response = await source.fetchRankings(prompt);

      return Right(CompletionsEntity.fromModel(response));
    } catch (e) {
      return Left(Exception());
    }
  }
}
