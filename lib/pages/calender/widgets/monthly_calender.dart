import 'package:al_qamar/bloc/calender/calender_bloc.dart';
import 'package:al_qamar/bloc/calender/calender_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/cubit/calender_cubit.dart';
import 'package:al_qamar/utils/extensions/datetime.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class MonthlyCalender extends StatefulWidget {
  const MonthlyCalender({
    super.key,
  });

  @override
  State<MonthlyCalender> createState() => _MonthlyCalenderState();
}

class _MonthlyCalenderState extends State<MonthlyCalender> {
  DateTime? selectedDate;
  DateTime focusedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CalenderCubit>(context).changeDatetime(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      margin: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'previousMonth'.localize(context),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: Fontsize.large),
                  ),
                  BlocBuilder<CalenderCubit, DateTime>(
                    builder: (context, state) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${state.getHijriMonth()} - ${state.getNextHijriMonth()} - ${state.getHijriYear()}',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: Fontsize.large),
                        ),
                        Text(
                          '${state.getGeregorianMonth()} - ${state.year}',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: Fontsize.large),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          width: 150,
                          height: 1,
                          color: AppColors.blue,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'nextMonth'.localize(context),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: Fontsize.large),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            TableCalendar(
              locale: CheckDirect.isRTL(context) ? 'ar_IQ' : 'en_Uk',
              availableGestures: AvailableGestures.horizontalSwipe,
              firstDay: DateTime(2000, 1, 1),
              lastDay: DateTime(2100, 1, 1),
              focusedDay: focusedDate,
              calendarFormat: CalendarFormat.month,
              currentDay: DateTime.now(),
              headerVisible: false,
              daysOfWeekHeight: 30,
              weekendDays: const [DateTime.friday, DateTime.saturday],
              onPageChanged: (date) {
                BlocProvider.of<CalenderCubit>(context).changeDatetime(date);
              },
              selectedDayPredicate: (date) {
                return isSameDay(selectedDate, date);
              },
              onDaySelected: (selectDate, focusDate) {
                if (selectedDate != selectDate) {
                  BlocProvider.of<CalenderBloc>(context)
                      .add(GetCalenderEvent(selectDate.getFormatDate()));
                }
                setState(() {
                  selectedDate = selectDate;
                  focusedDate = focusDate;
                });
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, day, focusedDay) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: Fontsize.large),
                        ),
                      ),
                      Positioned.directional(
                        textDirection: CheckDirect.isRTL(context)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        bottom: 0,
                        end: 10,
                        child: Text(
                          '${day.getHijriDate()}'.toArabic(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontSize: Fontsize.medium),
                        ),
                      ),
                    ],
                  ),
                ),
                outsideBuilder: (context, day, focusedDay) => const Text(''),
                defaultBuilder: (context, day, focusedDay) => Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${day.day}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: Fontsize.large),
                      ),
                    ),
                    Positioned.directional(
                      textDirection: CheckDirect.isRTL(context)
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      bottom: 0,
                      end: 10,
                      child: Text(
                        '${day.getHijriDate()}'.toArabic(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: Fontsize.medium),
                      ),
                    ),
                  ],
                ),
                todayBuilder: (context, day, focusedDay) => Container(
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: Fontsize.large),
                        ),
                      ),
                      Positioned.directional(
                        textDirection: CheckDirect.isRTL(context)
                            ? TextDirection.rtl
                            : TextDirection.ltr,
                        bottom: 0,
                        end: 10,
                        child: Text(
                          '${day.getHijriDate()}'.toArabic(),
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: Fontsize.medium),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                  fontSize: Fontsize.large,
                  color: AppColors.black,
                ),
                weekendStyle: TextStyle(
                  fontSize: Fontsize.large,
                  color: AppColors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
