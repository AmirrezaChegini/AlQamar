import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class TxtBtnMore extends StatelessWidget {
  const TxtBtnMore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: AppColors.grey,
        backgroundColor: AppColors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        textStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'iranyekanmed',
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('اقرا اکثرا'),
          SizedBox(width: 5),
          SvgIcon(
            icon: AppIcons.leftArrow,
            color: AppColors.grey,
            height: 10,
            width: 10,
          ),
        ],
      ),
    );
  }
}
