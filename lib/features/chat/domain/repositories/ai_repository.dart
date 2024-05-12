import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:rankai/features/chat/data/data_source/ai_data_source.dart';
import 'package:rankai/features/chat/data/models/completions/message_model.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_history_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/completion_entity.dart';
import 'package:rankai/features/chat/domain/entities/images/generated_image_entity.dart';
import 'package:rankai/features/chat/enums/message_role.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class ChatResponse extends Equatable {
  final GeneratedImageEntity? generatedImage;
  final CompletionsEntity completions;

  const ChatResponse({required this.completions, this.generatedImage});

  @override
  List<Object?> get props => [generatedImage, completions];
}

abstract class AIRepository {
  const AIRepository();

  Future<Either<Exception, ChatResponse>> fetchRankings(
    String prompt,
    ChatHistoryEntity chatHistory,
  );
}

class AIRepositoryImpl extends AIRepository {
  final AIDataSource _source;
  final GlobalAppLocalizations _localizations;

  const AIRepositoryImpl(this._source, this._localizations);

  @override
  Future<Either<Exception, ChatResponse>> fetchRankings(
    String prompt,
    ChatHistoryEntity chatHistory,
  ) async {
    try {
      final messageHistory = chatHistory.toMessageModel();
      final systemMessage = MessageModel(
        role: MessageRole.system.key,
        content:
            "You are a helpful assistant, but you only answer requests to rank things.",
      );

      final response = await _source
          .fetchRankings(messageHistory.followedBy([systemMessage]).toList());

      final completions = CompletionsEntity.fromModel(response);
      final messageContent = response.choices.first.message.content;
      GeneratedImageEntity? generatedImage;

      if (_shouldGenerateImage(messageContent)) {
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

  bool _shouldGenerateImage(String response) {
    return !response
        .toLowerCase()
        .contains(_localizations.current.sorry.toLowerCase());
  }
}
