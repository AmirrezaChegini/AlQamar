import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WeekCalender extends StatelessWidget {
  const WeekCalender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ar_IQ',
      focusedDay: DateTime.now(),
      availableGestures: AvailableGestures.all,
      firstDay: DateTime(2000, 1, 1),
      lastDay: DateTime(2100, 1, 1),
      calendarFormat: CalendarFormat.week,
      currentDay: DateTime.now(),
      headerVisible: false,
      daysOfWeekHeight: 30,
      weekendDays: const [DateTime.friday, DateTime.saturday],
      calendarStyle: CalendarStyle(
        canMarkersOverflow: true,
        todayDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppColors.blue.withOpacity(0.2),
        ),
        defaultTextStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.grey,
        ),
        todayTextStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.blue,
        ),
        weekendTextStyle: const TextStyle(
          fontSize: 12,
          color: AppColors.red,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(
          fontSize: 12,
          color: AppColors.grey,
        ),
        weekendStyle: TextStyle(
          fontSize: 12,
          color: AppColors.red,
        ),
      ),
    );
  }
}
