import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_item.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/share.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class ActionArticle extends StatelessWidget {
  const ActionArticle({
    super.key,
    required this.article,
  });

  final Article article;

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
              ActionItem(
                onTap: () {},
                icon: AppIcons.favorite,
                color: AppColors.red,
              ),
              const SizedBox(width: 8),
              ActionItem(
                onTap: () async =>
                    await ShareData.shareText(article.content.htmlToString()),
                icon: AppIcons.share,
                color: AppColors.blue,
              ),
              const SizedBox(width: 8),
              ActionItem(
                onTap: () {},
                icon: AppIcons.bookmark,
                color: AppColors.blue,
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const AppIcon(
                        icon: AppIcons.calender,
                        width: 15,
                        height: 15,
                        color: AppColors.black,
                      ),
                      Text(
                        ' ${article.updated}'.toArabic(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: Fontsize.large),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const AppIcon(
                        icon: AppIcons.pen,
                        width: 15,
                        height: 15,
                        color: AppColors.black,
                      ),
                      Text(
                        ' ${article.writer}',
                        softWrap: false,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: Fontsize.large),
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
