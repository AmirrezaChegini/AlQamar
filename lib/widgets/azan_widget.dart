import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class AzanWidget extends StatelessWidget {
  const AzanWidget({
    super.key,
    required this.city,
    required this.azanTime,
    this.backgroundColor = AppColors.white,
  });

  final String city;
  final AzanTime azanTime;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
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
                      .copyWith(fontSize: 12),
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
                      icon: index % 2 == 0
                          ? AppIcons.azan
                          : index == 5
                              ? AppIcons.moon
                              : AppIcons.sun,
                      width: 30,
                      height: 30,
                      color: AppColors.grey600,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      index == 0
                          ? azanTime.fajr
                          : index == 1
                              ? azanTime.sunrise
                              : index == 2
                                  ? azanTime.dhuhr
                                  : index == 3
                                      ? azanTime.sunset
                                      : index == 4
                                          ? azanTime.maghrib
                                          : azanTime.isha,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 12),
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
