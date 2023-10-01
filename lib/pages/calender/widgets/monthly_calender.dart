import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/utils/extensions/int.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
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
  late final ExpandableController _expandableCtrl;

  @override
  void initState() {
    super.initState();

    _hijriCtrl = HijriDatePickerController();
    _expandableCtrl = ExpandableController(initialExpanded: false);
  }

  @override
  void dispose() {
    _hijriCtrl.dispose();
    _expandableCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    _hijriCtrl.backward!();
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
                  title: 'الشهر ماضی',
                  icon: AppIcons.leftArrow,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${hijriMonth.getHijriMonth()} - ${(hijriMonth + 1).getHijriMonth()} - $hijriYear',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 12),
                    ),
                    Text(
                      '${georgiaMonth.getGeorgiaMonth()}  - ${(georgiaMonth + 1).getGeorgiaMonth()} - $georgiaYear',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 180,
                      height: 1,
                      color: AppColors.blue,
                    ),
                  ],
                ),
                TxtBtn(
                  onTap: () {
                    _hijriCtrl.forward!();
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
                  title: 'الشهر قادم',
                  icon: AppIcons.leftArrow,
                  ltr: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ExpandablePanel(
            controller: _expandableCtrl,
            collapsed: const SizedBox(),
            expanded: SfHijriDateRangePicker(
              controller: _hijriCtrl,
              navigationMode: DateRangePickerNavigationMode.none,
              headerHeight: 0,
              selectionColor: AppColors.blue,
              todayHighlightColor: AppColors.blue,
              selectionShape: DateRangePickerSelectionShape.rectangle,
            ),
          ),
          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color: AppColors.grey200,
          ),
          InkWell(
            onTap: () {
              setState(() {
                _expandableCtrl.toggle();
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Icon(
                _expandableCtrl.expanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: AppColors.grey600,
              ),
            ),
          )
        ],
      ),
    );
  }
}
