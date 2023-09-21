import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/utils/extensions/datetime.dart';
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
      calendarBuilders: CalendarBuilders(
        outsideBuilder: (context, day, focusedDay) => Container(
          alignment: Alignment.center,
          child: Text(
            '${day.getHijriDate()}',
            style: TextStyle(
              color: day.weekday == DateTime.friday ||
                      day.weekday == DateTime.saturday
                  ? AppColors.red
                  : AppColors.grey,
              fontSize: 12,
            ),
          ),
        ),
        defaultBuilder: (context, day, focusedDay) => Container(
          alignment: Alignment.center,
          child: Text(
            '${day.getHijriDate()}',
            style: TextStyle(
              fontSize: 12,
              color: day.weekday == DateTime.friday ||
                      day.weekday == DateTime.saturday
                  ? AppColors.red
                  : AppColors.grey,
            ),
          ),
        ),
        todayBuilder: (context, day, focusedDay) => Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: AppColors.blue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            '${focusedDay.getHijriDate()}',
            style: TextStyle(
              color: day.weekday == DateTime.friday ||
                      day.weekday == DateTime.saturday
                  ? AppColors.red
                  : AppColors.blue,
              fontSize: 12,
            ),
          ),
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
