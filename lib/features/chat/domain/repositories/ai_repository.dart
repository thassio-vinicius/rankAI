import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:rankai/features/chat/data/data_source/remote/ai_data_source.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';
import 'package:rankai/features/chat/domain/entities/completions/completion_entity.dart';
import 'package:rankai/features/chat/domain/entities/images/generated_image_entity.dart';
import 'package:rankai/features/chat/utils/message_role.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class ChatResponse {
  final GeneratedImageEntity? generatedImage;
  final CompletionsEntity completions;

  const ChatResponse({required this.completions, this.generatedImage});
}

class AIRepository {
  final AIDataSource _source;
  final GlobalAppLocalizations _localizations;
  const AIRepository(this._source, this._localizations);

  Future<Either<Exception, ChatResponse>> fetchRankings(
    String prompt,
  ) async {
    try {
      final userMessage = MessageModel(
        role: MessageRole.user.key,
        content: prompt,
        //content: prompt + _localizations.current.postPrompt,
      );
      final systemMessage = MessageModel(
        role: MessageRole.system.key,
        content:
            "You are a helpful assistant, but you only answer questions about rankings. And you only answer questions that were asked in the ${_localizations.locale.languageCode} language code",
      );

      final response = await _source.fetchRankings([
        systemMessage,
        userMessage,
      ]);

      final completions = CompletionsEntity.fromModel(response);
      final messageContent = response.choices.first.message.content;
      GeneratedImageEntity? generatedImage;

      if (shouldGenerateImage(messageContent)) {
        final imageResponse = await generateImage(messageContent);

        imageResponse.fold((l) {
          debugPrint(l.toString());
        }, (r) {
          generatedImage = r;
        });
      }

      return Right(
        ChatResponse(
          completions: completions,
          generatedImage: generatedImage,
        ),
      );
    } catch (e) {
      return Left(Exception());
    }
  }

  @visibleForTesting
  Future<Either<Exception, GeneratedImageEntity>> generateImage(
    String prompt,
  ) async {
    try {
      final response = await _source.generateImages(prompt);

      return Right(GeneratedImageEntity.fromModel(response));
    } catch (e) {
      return Left(Exception());
    }
  }

  @visibleForTesting
  bool shouldGenerateImage(String response) {
    return !response
        .toLowerCase()
        .contains(_localizations.current.sorry.toLowerCase());
  }
}
