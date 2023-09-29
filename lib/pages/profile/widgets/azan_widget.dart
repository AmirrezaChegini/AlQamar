import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class AzanWidget extends StatelessWidget {
  const AzanWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
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
                  'نجف',
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
                    SvgIcon(
                      icon: index % 2 != 0
                          ? AppIcons.azan
                          : index == 0
                              ? AppIcons.moon
                              : AppIcons.sun,
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '23:32',
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
