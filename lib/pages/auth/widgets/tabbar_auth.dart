import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class TabbarAuth extends StatelessWidget {
  const TabbarAuth({
    super.key,
    required this.tabCtrl,
  });

  final TabController tabCtrl;
  final List<String> texts = const [
    'تسجیل الدخول',
    'إنشاء ملف تحریف',
  ];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabCtrl,
      labelColor: AppColors.blue,
      unselectedLabelColor: AppColors.grey,
      indicatorColor: AppColors.blue,
      labelStyle:
          Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
      tabs: List.generate(
        texts.length,
        (index) => Tab(
          text: texts[index],
        ),
      ),
    );
  }
}
