import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/article/widgets/action_item.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ActionArticle extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.grey200,
      padding: const EdgeInsets.all(10).copyWith(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Container(
            height: 1,
            color: AppColors.grey600,
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
