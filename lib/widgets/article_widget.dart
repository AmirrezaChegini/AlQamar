import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/anim/fade_page_trans.dart';
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
        pageRoute(child: ArticlePage(article: article)),
      ),
      child: Card(
        color: AppColors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 6,
        margin: const EdgeInsets.all(0),
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
              MaskImage(
                  imageUrl: article.images.isNotEmpty ? article.images[0] : ''),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      style: Theme.of(context)
                          .textTheme
                          .displayLarge!
                          .copyWith(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      article.content.htmlToString(),
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
                        Flexible(
                          flex: 3,
                          child: Text(
                            ' ${article.writer}',
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 10,
                                ),
                          ),
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
      ),
    );
  }
}
