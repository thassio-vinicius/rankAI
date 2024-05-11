import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/utils/colors.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class MessageInputField extends StatelessWidget {
  final Function() onSubmit;
  final TextEditingController controller;
  const MessageInputField({
    super.key,
    required this.onSubmit,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final intl = sl<GlobalAppLocalizations>().current;
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.15,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: GoogleFonts.openSans(color: Colors.white),
                textInputAction: TextInputAction.newline,
                maxLines: null,
                cursorColor: AppColors.primaryBubble,
                decoration: InputDecoration(
                  hintText: intl.promptHint,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryBubble),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColors.primaryBubble),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintStyle: GoogleFonts.openSans(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: controller.text.isEmpty ? null : onSubmit,
              icon: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                padding: const EdgeInsets.all(8),
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
    );
  }
}
