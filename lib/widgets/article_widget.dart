import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/image_mask.dart';
import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  const ArticleWidget({
    super.key,
    this.backgroundColor = AppColors.white,
    required this.article,
  });

  final Color backgroundColor;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        fadePageTran(child: ArticlePage(article: article)),
      ),
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height / 7,
        padding: CheckDirect.isRTL(context)
            ? const EdgeInsets.only(left: 10)
            : const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: backgroundColor,
        ),
        child: Row(
          children: [
            MaskImage(imageUrl: article.images?[0]),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    article.content,
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
                        ' ${article.updateAt}',
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
                        ' ${article.writer}',
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
