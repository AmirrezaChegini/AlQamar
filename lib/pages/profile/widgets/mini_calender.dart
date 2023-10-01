import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/utils/extensions/int.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class MiniCalender extends StatelessWidget {
  MiniCalender({
    super.key,
  });

  final HijriCalendar _hijriCalendar = HijriCalendar.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
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
                _hijriCalendar.weekDay().getWeekDay(),
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 12,
                ),
              ),
              Text(
                '${_hijriCalendar.hDay}',
                style: const TextStyle(
                  color: AppColors.red,
                  fontSize: 20,
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
                _hijriCalendar.hMonth.getHijriMonth(),
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: 12,
                ),
              ),
              Text(
                '${_hijriCalendar.hYear}',
                style: const TextStyle(
                  color: AppColors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
