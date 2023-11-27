import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:flutter/material.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({
    super.key,
    required this.article,
  });

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
        shape: RoundedRectangleBorder(
          borderRadius: CheckDirect.isRTL(context)
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(60),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(8),
                ),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: CheckDirect.isRTL(context)
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(60),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(8),
                ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              CacheImage(
                  imageUrl: article.images.isNotEmpty ? article.images[0] : ''),
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
                      article.content.htmlToString(),
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 1,
                      color: AppColors.white.withOpacity(0.7),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(),
                        const AppIcon(
                          icon: AppIcons.calender,
                          width: 12,
                          height: 12,
                          color: AppColors.white,
                        ),
                        Text(
                          ' ${article.updateAt}',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontSize: 12,
                                  color: AppColors.white.withOpacity(0.7)),
                        ),
                        const SizedBox(width: 30),
                        const AppIcon(
                          icon: AppIcons.pen,
                          width: 12,
                          height: 12,
                          color: AppColors.white,
                        ),
                        Flexible(
                          flex: 3,
                          child: Text(
                            ' ${article.writer}',
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    fontSize: 12,
                                    color: AppColors.white.withOpacity(0.7)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
