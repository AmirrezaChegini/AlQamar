import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/home/widgets/week_calender.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          TitleWidget(
            title: '${HijriCalendar.now()}'.formatToArabicMonthYear(),
            showDivider: true,
          ),
          const WeekCalender(),
          const Divider(
            thickness: 1,
            color: AppColors.grey,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  text: 'ذکر الیوم: ',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 12),
                  children: [
                    TextSpan(
                      text: 'لا اله الا الله الملکوت الحق المبین',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.grey200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.asset(
                  AppIcons.arrow,
                  width: 10,
                  height: 10,
                  color: AppColors.grey,
                  matchTextDirection: true,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
