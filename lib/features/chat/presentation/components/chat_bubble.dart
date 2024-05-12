import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rankai/core/presentation/routes/my_navigator.dart';
import 'package:rankai/core/presentation/routes/route_names.dart';
import 'package:rankai/core/presentation/widgets/my_text.dart';
import 'package:rankai/core/utils/colors.dart';
import 'package:rankai/features/chat/domain/entities/chat/chat_message_entity.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessageEntity message;
  const ChatBubble({super.key, required this.message});

  String _formattedDate() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(message.timestamp);

    return DateFormat.Hm().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          message.fromUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: message.fromUser
                ? AppColors.primaryBubble
                : AppColors.darkBubble,
            borderRadius: BorderRadius.circular(12),
          ),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.75),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                message.content,
                style: MyTextStyle(
                  color: message.fromUser ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (message.image != null) ...[
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => MyNavigator(context).pushNamed(
                    RouteNames.imagePreview,
                    extra: message.toUint8List()!,
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Hero(
                        tag: message.toUint8List()!,
                        child: Image.memory(
                          message.toUint8List()!,
                          height: 300,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        const SizedBox(height: 4),
        MyText(
          _formattedDate(),
          style: MyTextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
