import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/pages/home/widgets/week_calender.dart';
import 'package:al_qamar/utils/extensions/int.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hijri/hijri_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(
            title:
                '${HijriCalendar.now().hMonth.getHijriMonth()} ${HijriCalendar.now().hYear}',
            showDivider: true,
            crossAlignment: CrossAxisAlignment.end,
            dividerWidth: 130,
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: WeekCalender(),
          ),
          const Divider(
            thickness: 1,
            endIndent: 10,
            indent: 10,
            color: AppColors.grey,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                tabController.animateTo(0);
                BlocProvider.of<BottomnavCubit>(context).changeIndex(0);
              },
              child: Row(
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
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const AppIcon(
                      icon: AppIcons.leftArrow,
                      color: AppColors.grey,
                      height: 20,
                      width: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
