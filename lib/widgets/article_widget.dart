import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/widgets/image_mask.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          const MaskImage(image: AppImages.img2),
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
                    Image.asset(
                      AppIcons.calendar,
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
                    const SizedBox(width: 20),
                    Image.asset(
                      AppIcons.pen,
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
