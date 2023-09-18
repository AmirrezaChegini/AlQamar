import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:flutter/material.dart';

class BtnAuth extends StatelessWidget {
  const BtnAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(150, 46),
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        textStyle: Theme.of(context).textTheme.labelMedium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Image.asset(
              AppIcons.arrow,
              width: 10,
              height: 10,
              color: AppColors.white,
              matchTextDirection: true,
            ),
          ),
          const VerticalDivider(
            color: AppColors.white,
            thickness: 0.5,
            indent: 8,
            endIndent: 8,
          ),
          const Text('المرحلة التالية'),
        ],
      ),
    );
  }
}
