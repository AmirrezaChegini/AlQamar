import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class MiniCalender extends StatelessWidget {
  const MiniCalender({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الخمیس',
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 12,
                ),
              ),
              Text(
                '18',
                style: TextStyle(
                  color: AppColors.red,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.grey,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ربیع الاول',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 12,
                ),
              ),
              Text(
                '2023',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
