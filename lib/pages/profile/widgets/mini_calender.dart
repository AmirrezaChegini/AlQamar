import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/utils/extensions/int.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

class MiniCalender extends StatelessWidget {
  MiniCalender({
    super.key,
  });

  final HijriCalendar _hijriCalendar = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CheckDirect.isRTL(context)
                    ? _hijriCalendar.weekDay().getWeekDay()
                    : DateFormat('EEEE').format(DateTime.now()),
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: Fontsize.large,
                ),
              ),
              Text(
                CheckDirect.isRTL(context)
                    ? '${_hijriCalendar.hDay}'.toArabic()
                    : '${DateTime.now().day}',
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: Fontsize.huge,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                CheckDirect.isRTL(context)
                    ? _hijriCalendar.hMonth.getHijriMonth().toArabic()
                    : DateFormat('MMMM').format(DateTime.now()),
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: Fontsize.large,
                ),
              ),
              Text(
                CheckDirect.isRTL(context)
                    ? '${_hijriCalendar.hYear}'.toArabic()
                    : '${DateTime.now().year}',
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: Fontsize.huge,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
