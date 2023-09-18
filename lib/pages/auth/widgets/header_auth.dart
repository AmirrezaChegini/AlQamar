import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/Splash-Auth-Color.png'),
                fit: BoxFit.fill,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.red.withOpacity(0.8),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'مرحباً',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 22),
                ),
              ),
              Divider(
                thickness: 2,
                color: AppColors.white,
                indent: MediaQuery.of(context).size.width / 1.4,
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: FittedBox(
                  child: Text(
                      'إذا کان لدیک حساب، یرجی تسجیل الدخول أو إنشاء ملف شخصی جدید',
                      style: Theme.of(context).textTheme.labelMedium),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
