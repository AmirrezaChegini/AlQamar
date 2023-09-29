import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/widgets/image_mask.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    this.backgroundColor = AppColors.white,
  });

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundColor,
      ),
      child: Row(
        children: [
          const Stack(
            children: [
              MaskImage(image: AppImages.img2),
              Positioned(
                right: 20,
                child: SvgIcon(
                  icon: AppIcons.bookmark,
                  width: 20,
                  height: 20,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'یقول المحافظ ان مستمسری العملات',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
                Text(
                  'شسیشسیییییییییییییییییییییییییییییییییییییییییییییییییییییییییییییییییییسسسسسسسسسییییی',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 10, height: 1),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Divider(
                  thickness: 1,
                ),
                Row(
                  children: [
                    const Spacer(),
                    const SvgIcon(
                      icon: AppIcons.calender,
                      width: 10,
                      height: 10,
                      color: AppColors.grey,
                    ),
                    Text(
                      ' 1402/03/03',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 10),
                    ),
                    const Spacer(),
                    const SvgIcon(
                      icon: AppIcons.pen,
                      width: 10,
                      height: 10,
                      color: AppColors.grey,
                    ),
                    Text(
                      ' بواسظ امیررضا چگینی',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 10),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
