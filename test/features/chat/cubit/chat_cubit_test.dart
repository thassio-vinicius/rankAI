import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_history_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/choice_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/completion_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/message_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/usage_entity.dart';
import 'package:rankai/features/chat/domain/repositories/ai_repository.dart';
import 'package:rankai/features/chat/enums/message_role.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_state.dart';

class MockStorage extends Mock implements Storage {}

class MockAIRepository extends Mock implements AIRepository {}

void main() {
  const completionsEntity = CompletionsEntity(
    choices: [
      ChoiceEntity(
        index: 0,
        message: MessageEntity(
          role: MessageRole.assistant,
          content: '',
        ),
        finishReason: '',
      ),
    ],
    created: 0,
    object: '',
    model: '',
    id: '',
    usage: UsageEntity(
      promptTokens: 1,
      completionTokens: 1,
      totalTokens: 1,
    ),
  );

  const chatHistoryEntity = ChatHistoryEntity(
    messages: [],
    startingTimestamp: 0,
  );

  late Storage storage;

  setUpAll(() {
    registerFallbackValue(chatHistoryEntity);
  });

  setUp(() {
    storage = MockStorage();
    when(
      () => storage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  group('ChatCubit', () {
    late ChatCubit cubit;
    late AIRepository mockRepository;

    setUp(() {
      mockRepository = MockAIRepository();
      cubit = ChatCubit(mockRepository);
    });

    tearDown(() {
      cubit.close();
    });

    test('fromJson returns correct state', () {
      final json = {
        'runtimeType': 'ChatInitialState',
        'chatHistoryEntity': chatHistoryEntity.toJson(),
      };
      const expectedState = ChatInitialState(
        chatHistoryEntity: chatHistoryEntity,
      );

      cubit.emit(expectedState);

      final result = cubit.fromJson(json);

      expect(result, equals(expectedState));
    });

    test('toJson returns correct json', () {
      const state = MessageLoadedState(
        completionsEntity: completionsEntity,
        chatHistoryEntity: chatHistoryEntity,
      );
      final expectedJson = {
        'runtimeType': 'MessageLoadedState',
        'chatHistoryEntity': jsonEncode(chatHistoryEntity.toJson()),
      };

      final result = cubit.toJson(state);

      expect(result, equals(expectedJson));
    });
  });
}
