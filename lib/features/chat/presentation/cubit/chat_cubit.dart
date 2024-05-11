import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rankai/core/utils/base_cubit.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_message_entity.dart';
import 'package:rankai/features/chat/domain/repositories/ai_repository.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_state.dart';

class ChatCubit extends BaseCubit<ChatState> with HydratedMixin {
  ChatCubit(this._repository) : super(const ChatInitialState()) {
    hydrate();
  }

  final AIRepository _repository;

  Future<void> fetchRankings(String prompt) async {
    _addMessage(prompt, true);
    emit(MessageLoadingState(chatHistoryEntity: state.chatHistoryEntity));

    final response = await _repository.fetchRankings(prompt);

    response.fold(
      (l) {
        emit(MessageFailedState(chatHistoryEntity: state.chatHistoryEntity));
      },
      (r) {
        _addMessage(r.choices.first.message.content, false);

        emit(MessageLoadedState(
          completionsEntity: r,
          chatHistoryEntity: state.chatHistoryEntity,
        ));
      },
    );
  }

  void resetState() {
    emit(const ChatInitialState());
  }

  @override
  ChatState? fromJson(Map<String, dynamic> json) {
    try {
      final type = json['runtimeType'] as String;

      if (type == 'MessageLoadedState') {
        return MessageLoadedState.fromJson(json);
      } else if (type == 'MessageLoadingState') {
        return MessageLoadingState.fromJson(json);
      } // else if (type == 'MessageFailedState') {
      //  return MessageFailedState.fromJson(json);
      // }

      return const ChatInitialState();
    } catch (e) {
      return const ChatInitialState();
    }
  }

  @override
  Map<String, dynamic>? toJson(ChatState state) {
    return state.toJson();
  }

  void _addMessage(String content, bool fromUser) {
    List<ChatMessageEntity> messages =
        List.from(state.chatHistoryEntity.messages);
    bool isFirstMessage = messages.isEmpty;

    final message = ChatMessageEntity(
      fromUser: fromUser,
      content: content,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    messages.add(message);

    state.copyWith(
      chatHistoryEntity: state.chatHistoryEntity.copyWith(
        messages: messages,
        startingTimestamp:
            isFirstMessage ? DateTime.now().millisecondsSinceEpoch : null,
      ),
    );
  }
}
