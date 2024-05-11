import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rankai/core/injector.dart';
import 'package:rankai/core/presentation/widgets/my_text.dart';
import 'package:rankai/core/utils/colors.dart';
import 'package:rankai/l10n/global_app_localizations.dart';

class DateChip extends StatelessWidget {
  final int timestamp;
  const DateChip(this.timestamp, {super.key});

  String _formattedDate() {
    final intl = sl<GlobalAppLocalizations>().current;

    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

    int diff = DateTime.now().difference(date).inDays;

    if (diff < 1) {
      return intl.today;
    } else if (diff < 2) {
      return intl.yesterday;
    } else if (diff < 30) {
      return intl.daysAgo(diff);
    } else if (diff < 365) {
      return intl.monthsAgo(diff % 30);
    } else {
      return DateFormat.yMd().format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: MyText(
        _formattedDate(),
        style: MyTextStyle(
          color: AppColors.greyFont,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
