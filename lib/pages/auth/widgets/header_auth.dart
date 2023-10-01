import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.red.withOpacity(0.7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'مرحباً',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontSize: 22),
              ),
              Container(
                height: 2,
                color: AppColors.white,
                width: 100,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              'أنت تستخدم البرنامج کضیف',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 13),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: FittedBox(
              child: Text(
                  'إذا کان لدیک حساب، یرجی تسجیل الدخول أو إنشاء ملف شخصی جدید',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
