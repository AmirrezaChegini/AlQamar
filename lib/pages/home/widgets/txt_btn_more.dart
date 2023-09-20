import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('اقرا اکثرا'),
          const SizedBox(width: 5),
          Image.asset(
            AppIcons.arrow,
            width: 10,
            height: 10,
            color: AppColors.grey,
            matchTextDirection: true,
          ),
        ],
      ),
    );
  }
}
