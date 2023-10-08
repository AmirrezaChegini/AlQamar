import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class BtnAuth extends StatelessWidget {
  const BtnAuth({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(160, 40),
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        textStyle:
            Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 11),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const VerticalDivider(
            color: AppColors.white,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          const SvgIcon(
            icon: AppIcons.rightArrow,
            color: AppColors.white,
            height: 20,
            width: 20,
            matchDirection: true,
          ),
        ],
      ),
    );
  }
}
