import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_history_entity.dart';
import 'package:rankai/features/chat/domain/entities/completions/completion_entity.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  abstract final ChatHistoryEntity chatHistoryEntity;

  Map<String, dynamic> toJson();

  bool get isEmpty => chatHistoryEntity.messages.isEmpty;

  ChatState copyWith({ChatHistoryEntity? chatHistoryEntity});

  @override
  List<Object?> get props => [chatHistoryEntity];
}

class ChatInitialState extends ChatState {
  const ChatInitialState({
    this.chatHistoryEntity = const ChatHistoryEntity(
      messages: [],
      startingTimestamp: 0,
    ),
  });

  @override
  final ChatHistoryEntity chatHistoryEntity;

  @override
  Map<String, dynamic> toJson() {
    return {
      'runtimeType': runtimeType.toString(),
    };
  }

  factory ChatInitialState.fromJson(Map<String, dynamic> json) {
    return const ChatInitialState();
  }

  @override
  ChatState copyWith({ChatHistoryEntity? chatHistoryEntity}) {
    return const ChatInitialState();
  }
}

class MessageLoadedState extends ChatState {
  const MessageLoadedState({
    this.completionsEntity,
    required this.chatHistoryEntity,
  });

  final CompletionsEntity? completionsEntity;

  factory MessageLoadedState.fromJson(Map<String, dynamic> json) {
    return MessageLoadedState(
      chatHistoryEntity:
          ChatHistoryEntity.fromJson(jsonDecode(json['chatHistoryEntity'])),
    );
  }

  @override
  MessageLoadedState copyWith({
    CompletionsEntity? completionsEntity,
    ChatHistoryEntity? chatHistoryEntity,
  }) {
    return MessageLoadedState(
      completionsEntity: completionsEntity ?? this.completionsEntity,
      chatHistoryEntity: chatHistoryEntity ?? this.chatHistoryEntity,
    );
  }

  @override
  final ChatHistoryEntity chatHistoryEntity;

  @override
  Map<String, dynamic> toJson() {
    return {
      'runtimeType': runtimeType.toString(),
      'chatHistoryEntity': jsonEncode(chatHistoryEntity.toJson()),
    };
  }

  @override
  List<Object?> get props => [completionsEntity];
}

class MessageLoadingState extends ChatState {
  const MessageLoadingState({required this.chatHistoryEntity});

  factory MessageLoadingState.fromJson(Map<String, dynamic> json) {
    return MessageLoadingState(
      chatHistoryEntity:
          ChatHistoryEntity.fromJson(jsonDecode(json['chatHistoryEntity'])),
    );
  }

  @override
  final ChatHistoryEntity chatHistoryEntity;

  @override
  Map<String, dynamic> toJson() {
    return {
      'runtimeType': runtimeType.toString(),
      'chatHistoryEntity': jsonEncode(chatHistoryEntity.toJson()),
    };
  }

  @override
  MessageLoadingState copyWith({
    ChatHistoryEntity? chatHistoryEntity,
  }) {
    return MessageLoadingState(
      chatHistoryEntity: chatHistoryEntity ?? this.chatHistoryEntity,
    );
  }
}

class MessageFailedState extends ChatState {
  const MessageFailedState({required this.chatHistoryEntity});

  factory MessageFailedState.fromJson(Map<String, dynamic> json) {
    return MessageFailedState(
      chatHistoryEntity:
          ChatHistoryEntity.fromJson(jsonDecode(json['chatHistoryEntity'])),
    );
  }
  @override
  final ChatHistoryEntity chatHistoryEntity;

  @override
  Map<String, dynamic> toJson() {
    return {
      'runtimeType': runtimeType.toString(),
      'chatHistoryEntity': jsonEncode(chatHistoryEntity.toJson()),
    };
  }

  @override
  MessageFailedState copyWith({
    ChatHistoryEntity? chatHistoryEntity,
  }) {
    return MessageFailedState(
      chatHistoryEntity: chatHistoryEntity ?? this.chatHistoryEntity,
    );
  }
}
