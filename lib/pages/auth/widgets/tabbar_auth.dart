import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class TabbarAuth extends StatelessWidget {
  const TabbarAuth({
    super.key,
    required this.tabCtrl,
  });

  final TabController tabCtrl;
  final List<String> texts = const [
    'إنشاء ملف تحریف',
    'تسجیل الدخول',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 1,
          color: AppColors.grey600,
        ),
        TabBar(
          controller: tabCtrl,
          labelColor: AppColors.blue,
          unselectedLabelColor: AppColors.grey,
          indicatorColor: AppColors.blue,
          dividerColor: AppColors.grey,
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
          tabs: List.generate(
            texts.length,
            (index) => Tab(
              text: texts[index],
            ),
          ),
        ),
      ],
    );
  }
}
