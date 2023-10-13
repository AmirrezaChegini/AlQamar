import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(8),
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(60),
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            AppImages.img1,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [
                AppColors.black,
                AppColors.transparent,
                AppColors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'ما الذی یجب مراقبة فی المناظرة التمهیدیة الأولی اللحزب الجمهوری فی الدورة الانتخابیة لعام 2024',
                  maxLines: 2,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 1,
                  color: AppColors.white,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Spacer(),
                    const AppIcon(
                      icon: AppIcons.calender,
                      width: 12,
                      height: 12,
                      color: AppColors.white,
                    ),
                    Text(
                      ' 1402/03/03',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 30),
                    const AppIcon(
                      icon: AppIcons.pen,
                      width: 12,
                      height: 12,
                      color: AppColors.white,
                    ),
                    Text(
                      ' بواسظ امیررضا چگینی',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
