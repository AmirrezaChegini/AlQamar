import 'package:al_qamar/bloc/calender/calender_bloc.dart';
import 'package:al_qamar/bloc/calender/calender_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/utils/extensions/datetime.dart';
import 'package:al_qamar/utils/extensions/int.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MonthlyCalender extends StatefulWidget {
  const MonthlyCalender({
    super.key,
  });

  @override
  State<MonthlyCalender> createState() => _MonthlyCalenderState();
}

class _MonthlyCalenderState extends State<MonthlyCalender> {
  int hijriMonth = HijriCalendar.now().hMonth;
  int georgiaMonth = DateTime.now().month;
  int hijriYear = HijriCalendar.now().hYear;
  int georgiaYear = DateTime.now().year;

  late final HijriDatePickerController _hijriCtrl;
  late final DateRangePickerController _georgiaCtrl;

  @override
  void initState() {
    super.initState();
    _hijriCtrl = HijriDatePickerController();
    _georgiaCtrl = DateRangePickerController();
  }

  @override
  void dispose() {
    _hijriCtrl.dispose();
    _georgiaCtrl.dispose();
    super.dispose();
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
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TxtBtn(
                    onTap: () {
                      if (CheckDirect.isRTL(context)) {
                        _hijriCtrl.backward!();
                      } else {
                        _georgiaCtrl.backward!();
                      }

                      setState(() {
                        if (hijriMonth == 1) {
                          hijriMonth = 12;
                          --hijriYear;
                        } else {
                          --hijriMonth;
                        }

                        if (georgiaMonth == 1) {
                          georgiaMonth = 12;
                          --georgiaYear;
                        } else {
                          --georgiaMonth;
                        }
                      });
                    },
                    title: 'previousMonth'.localize(context),
                    icon: AppIcons.leftArrow,
                    textDecoration: CheckDirect.isRTL(context)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
                    fontSize: Fontsize.small,
                    iconSize: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${hijriMonth.getHijriMonth()} - ${(hijriMonth + 1).getHijriMonth()} - $hijriYear'
                            .toArabic(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: Fontsize.large),
                      ),
                      Text(
                        '${georgiaMonth.getGeorgiaMonth()}  - ${(georgiaMonth + 1).getGeorgiaMonth()} - $georgiaYear',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: Fontsize.small),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        width: 150,
                        height: 1,
                        color: AppColors.blue,
                      ),
                    ],
                  ),
                  TxtBtn(
                    onTap: () {
                      if (CheckDirect.isRTL(context)) {
                        _hijriCtrl.forward!();
                      } else {
                        _georgiaCtrl.forward!();
                      }
                      setState(() {
                        if (hijriMonth == 12) {
                          hijriMonth = 1;
                          ++hijriYear;
                        } else {
                          ++hijriMonth;
                        }

                        if (georgiaMonth == 12) {
                          georgiaMonth = 1;
                          ++georgiaYear;
                        } else {
                          ++georgiaMonth;
                        }
                      });
                    },
                    title: 'nextMonth'.localize(context),
                    icon: AppIcons.leftArrow,
                    fontSize: Fontsize.small,
                    iconSize: 15,
                    textDecoration: CheckDirect.isRTL(context)
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CheckDirect.isRTL(context)
                ? SfHijriDateRangePicker(
                    controller: _hijriCtrl,
                    navigationMode: DateRangePickerNavigationMode.none,
                    headerHeight: 0,
                    selectionColor: AppColors.blue,
                    todayHighlightColor: AppColors.blue,
                    selectionShape: DateRangePickerSelectionShape.rectangle,
                    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                      BlocProvider.of<CalenderBloc>(context).add(
                          GetCalenderEvent(_hijriCtrl.selectedDate!
                              .toDateTime()
                              .getFormatDate()));
                    },
                  )
                : SfDateRangePicker(
                    controller: _georgiaCtrl,
                    navigationMode: DateRangePickerNavigationMode.none,
                    headerHeight: 0,
                    selectionColor: AppColors.blue,
                    todayHighlightColor: AppColors.blue,
                    selectionShape: DateRangePickerSelectionShape.rectangle,
                    onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                      BlocProvider.of<CalenderBloc>(context).add(
                          GetCalenderEvent(
                              _georgiaCtrl.selectedDate!.getFormatDate()));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
