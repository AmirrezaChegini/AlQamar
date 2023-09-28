import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MonthlyCalender extends StatelessWidget {
  MonthlyCalender({
    super.key,
  });

  final HijriDatePickerController _controller = HijriDatePickerController();

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
                    _controller.backward!();
                  },
                  title: 'الشهر ماضی',
                  icon: AppIcons.leftArrow,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'محرم - صفر - 1445',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 12),
                    ),
                    Text(
                      'July - August - 2023',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 100,
                      height: 1,
                      color: AppColors.blue,
                    ),
                  ],
                ),
                TxtBtn(
                  onTap: () {
                    _controller.forward!();
                  },
                  title: 'الشهر قادم',
                  icon: AppIcons.leftArrow,
                  ltr: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SfHijriDateRangePicker(
            controller: _controller,
            navigationMode: DateRangePickerNavigationMode.none,
            headerHeight: 0,
            selectionColor: AppColors.blue,
            todayHighlightColor: AppColors.blue,
            selectionShape: DateRangePickerSelectionShape.rectangle,
          ),
        ],
      ),
    );
  }
}
