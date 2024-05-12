import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rankai/features/chat/data/data_source/ai_data_source.dart';
import 'package:rankai/features/chat/data/models/images/generated_image_model.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_history_entity.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_message_entity.dart';
import 'package:rankai/features/chat/domain/entities/images/generated_image_entity.dart';
import 'package:rankai/features/chat/domain/repositories/ai_repository.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class MockAIDataSource extends Mock implements AIDataSource {}

class MockGlobalAppLocalizations extends Mock
    implements GlobalAppLocalizations {}

void main() {
  late AIRepositoryImpl repository;
  late MockAIDataSource mockDataSource;
  late MockGlobalAppLocalizations mockLocalizations;

  setUp(() {
    mockDataSource = MockAIDataSource();
    mockLocalizations = MockGlobalAppLocalizations();
    repository = AIRepositoryImpl(mockDataSource, mockLocalizations);
  });

  group('AIRepositoryImpl', () {
    const prompt = 'Test prompt';
    final chatHistory = ChatHistoryEntity(messages: [
      ChatMessageEntity(
        content: 'Hello',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        fromUser: true,
      )
    ], startingTimestamp: DateTime.now().millisecondsSinceEpoch);

    test('fetchRankings returns Left on failure', () async {
      when(() => mockDataSource.fetchRankings(any())).thenThrow(Exception());

      final result = await repository.fetchRankings(prompt, chatHistory);

      expect(result, isA<Left>());
    });

    test('generateImage returns GeneratedImageEntity on successful response',
        () async {
      final generatedImageModel = GeneratedImageModel(
        b64Json: '',
        created: 0,
      );

      when(() => mockDataSource.generateImages(any()))
          .thenAnswer((_) async => generatedImageModel);

      final result = await repository.generateImage(prompt);

      expect(result, isA<Right>());
      expect(result.getOrElse(() => throw Exception()),
          isA<GeneratedImageEntity>());
    });

    test('generateImage returns Left on failure', () async {
      when(() => mockDataSource.generateImages(any())).thenThrow(Exception());

      final result = await repository.generateImage(prompt);

      expect(result, isA<Left>());
    });
  });
}
