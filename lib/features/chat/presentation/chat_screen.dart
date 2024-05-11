import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/presentation/widgets/my_text.dart';
import 'package:rankai/core/utils/colors.dart';
import 'package:rankai/features/chat/presentation/components/chat_bubble.dart';
import 'package:rankai/features/chat/presentation/components/date_chip.dart';
import 'package:rankai/features/chat/presentation/components/loading_animation.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:rankai/features/chat/presentation/cubit/chat_state.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _promptController = TextEditingController();

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
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: BlocConsumer<ChatCubit, ChatState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        bool isEmpty = state.isEmpty;

                        if (isEmpty) {
                          return Center(
                            child: MyText.mediumSmall(
                              intl.emptyChatMessage,
                              style: MyTextStyle(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }

                        if (state is MessageFailedState) {
                          return Center(
                            child: MyText.mediumSmall(
                              intl.genericErrorMessage,
                              style: MyTextStyle(
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
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
                                ChatBubble(
                                  content: message.content,
                                  fromUser: message.fromUser,
                                  timestamp: message.timestamp,
                                ),
                                if (state is MessageLoadingState)
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 8,
                                      ),
                                      child: const JumpingDotsProgressIndicator(
                                        fontSize: 14,
                                        color: AppColors.darkBackground,
                                      ),
                                    ),
                                  )
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: AppColors.darkBackground,
                      border: Border(
                        top: BorderSide(color: Colors.grey),
                      ),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: SafeArea(
                      top: false,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.sizeOf(context).height * 0.15,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _promptController,
                                  style:
                                      GoogleFonts.openSans(color: Colors.white),
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: intl.promptHint,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    hintStyle: GoogleFonts.openSans(
                                        color: Colors.grey),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              IconButton(
                                onPressed: _promptController.text.isEmpty
                                    ? null
                                    : () {
                                        context.read<ChatCubit>().fetchRankings(
                                            _promptController.text);
                                        _promptController.text = '';
                                        FocusScope.of(context).unfocus();
                                      },
                                icon: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primary,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  child: const Center(
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
