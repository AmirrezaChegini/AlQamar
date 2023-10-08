import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/article/widgets/action_item.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ActionArticle extends StatelessWidget {
  const ActionArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const ActionItem(icon: AppIcons.favorite),
              const SizedBox(width: 8),
              const ActionItem(icon: AppIcons.share),
              const SizedBox(width: 8),
              const ActionItem(icon: AppIcons.bookmark),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const SvgIcon(
                        icon: AppIcons.calender,
                        width: 10,
                        height: 10,
                        color: AppColors.black,
                      ),
                      Text(
                        ' 1402/03/03',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const SvgIcon(
                        icon: AppIcons.pen,
                        width: 10,
                        height: 10,
                        color: AppColors.black,
                      ),
                      Text(
                        ' بواسظ امیررضا چگینی',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            height: 1,
            color: AppColors.grey600,
          )
        ],
      ),
    );
  }
}
