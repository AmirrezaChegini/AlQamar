import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
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
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, fadePageTran(child: const ArticlePage())),
      child: Container(
        height: MediaQuery.of(context).size.height / 7,
        padding: CheckDirect.isRTL(context)
            ? const EdgeInsets.only(left: 10)
            : const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
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
                      const AppIcon(
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
                      const AppIcon(
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
                      const Spacer(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
