import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/presentation/widgets/app_logo.dart';
import 'package:rankai/core/presentation/widgets/my_text.dart';
import 'package:rankai/core/utils/colors.dart';
import 'package:rankai/features/chat/presentation/components/chat_bubble.dart';
import 'package:rankai/features/chat/presentation/components/date_chip.dart';
import 'package:rankai/features/chat/presentation/components/loading_animation.dart';
import 'package:rankai/features/chat/presentation/components/message_input_field.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_state.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _promptController = TextEditingController();
  final _scrollController = ScrollController(keepScrollOffset: true);

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent * 2,
        duration: kThemeAnimationDuration,
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 20),
          curve: Curves.ease,
        );
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;

    return BlocProvider(
      create: (_) => ChatCubit(sl()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: AppLogo(large: false),
                    ),
                    Builder(builder: (context) {
                      return IconButton(
                        onPressed: () {
                          context.read<ChatCubit>().deleteHistory();
                        },
                        icon: Transform.rotate(
                          angle: 1.1,
                          child: const Icon(
                            Icons.restart_alt,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  width: MediaQuery.sizeOf(context).width,
                  height: 1,
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: BlocConsumer<ChatCubit, ChatState>(
                      listener: (context, state) {
                        if (state is MessageLoadedState) {
                          _scrollToBottom();
                        }
                      },
                      builder: (context, state) {
                        bool isEmpty = state.isEmpty;

                        if (isEmpty) {
                          return Center(
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.65,
                              child: MyText.mediumSmall(
                                intl.emptyChatMessage,
                                style: MyTextStyle(
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }

                        if (state is MessageFailedState) {
                          return Center(
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.65,
                              child: MyText.mediumSmall(
                                intl.genericErrorMessage,
                                style: MyTextStyle(
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16),
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          itemCount: state.chatHistoryEntity.messages.length,
                          itemBuilder: (context, index) {
                            final message =
                                state.chatHistoryEntity.messages[index];
                            return Column(
                              crossAxisAlignment: message.fromUser
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                if (index == 0)
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 16.0),
                                    child: Center(
                                      child: DateChip(
                                        state.chatHistoryEntity
                                            .startingTimestamp,
                                      ),
                                    ),
                                  ),
                                ChatBubble(message: message),
                                if (state is MessageLoadingState &&
                                    index + 1 ==
                                        state.chatHistoryEntity.messages.length)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: IntrinsicWidth(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.darkBubble,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 16,
                                        ),
                                        child: const CustomLoadingAnimation(
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 12),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        border: Border(
                          top: BorderSide(color: Colors.grey),
                        ),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: SafeArea(
                        top: false,
                        child: MessageInputField(
                          onSubmit: () {
                            context
                                .read<ChatCubit>()
                                .fetchRankings(_promptController.text);
                            _scrollToBottom();
                            _promptController.text = '';
                            FocusScope.of(context).unfocus();
                          },
                          controller: _promptController,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
