import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.showDivider = false,
    this.crossAlignment = CrossAxisAlignment.center,
    this.dividerWidth = 100,
  });

  final String title;
  final bool showDivider;
  final CrossAxisAlignment crossAlignment;
  final double dividerWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          // width: 100,
          child: Column(
            crossAxisAlignment: crossAlignment,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontSize: 14),
              ),
              if (showDivider) ...{
                const SizedBox(height: 6),
                Container(
                  height: 1,
                  width: dividerWidth,
                  color: AppColors.blue,
                ),
              }
            ],
          ),
        ),
      ],
    );
  }
}
