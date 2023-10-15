import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class TxtBtn extends StatelessWidget {
  const TxtBtn({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
  });

  final Function()? onTap;
  final String title;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl == Directionality.of(context)
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: TextButton.icon(
        onPressed: onTap,
        icon: AppIcon(
          icon: icon,
          color: AppColors.grey,
          height: 20,
          width: 20,
          matchDirection: true,
        ),
        label: Text(title),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.grey,
          textStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 10),
        ),
      ),
    );
  }
}
