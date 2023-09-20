import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
    this.showDivider = false,
  });

  final String title;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              if (showDivider)
                const Divider(
                  thickness: 1,
                  endIndent: 0,
                  indent: 0,
                  color: AppColors.blue,
                )
            ],
          ),
        )
      ],
    );
  }
}
