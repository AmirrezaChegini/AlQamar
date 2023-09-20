import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  CalendarFormat _format = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: TableCalendar(
            focusedDay: DateTime.now(),
            firstDay: DateTime(2000, 1, 1),
            lastDay: DateTime(2100, 1, 1),
            calendarFormat: _format,
            currentDay: DateTime.now(),
            pageJumpingEnabled: true,
            formatAnimationCurve: Curves.ease,
            formatAnimationDuration: const Duration(milliseconds: 400),
            pageAnimationEnabled: true,
            onFormatChanged: (format) {
              setState(() {
                _format == CalendarFormat.week
                    ? _format = CalendarFormat.month
                    : _format = CalendarFormat.week;
              });
            },
          ),
        ),
      ),
    );
  }
}
