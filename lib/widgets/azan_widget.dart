import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class AzanWidget extends StatelessWidget {
  const AzanWidget({
    super.key,
    required this.city,
    required this.azanTime,
    this.backgroundColor = AppColors.white,
    this.elevation = 0,
  });

  final String city;
  final AzanTime azanTime;
  final Color backgroundColor;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      color: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            margin: const EdgeInsets.only(top: 5, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  city,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: Fontsize.large),
                ),
                const SizedBox(height: 3),
                Container(
                  height: 1,
                  color: AppColors.grey,
                )
              ],
            ),
          ),
          Row(
            children: List.generate(
              6,
              (index) => Expanded(
                child: Column(
                  children: [
                    AppIcon(
                      icon: index % 2 != 0
                          ? AppIcons.azan
                          : index == 0
                              ? AppIcons.moon
                              : AppIcons.sun,
                      width: 30,
                      height: 30,
                      color: AppColors.grey600,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      index == 0
                          ? azanTime.midnight.toArabic()
                          : index == 1
                              ? azanTime.isha.toArabic()
                              : index == 2
                                  ? azanTime.sunset.toArabic()
                                  : index == 3
                                      ? azanTime.dhuhr.toArabic()
                                      : index == 4
                                          ? azanTime.sunrise.toArabic()
                                          : azanTime.fajr.toArabic(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: Fontsize.large),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
