import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class TxtBtn extends StatelessWidget {
  const TxtBtn({
    super.key,
    this.onTap,
    required this.title,
    required this.icon,
    this.ltr = false,
  });

  final Function()? onTap;
  final String title;
  final String icon;
  final bool ltr;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ltr ? TextDirection.ltr : TextDirection.rtl,
      child: TextButton.icon(
        onPressed: onTap,
        icon: SvgIcon(
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
