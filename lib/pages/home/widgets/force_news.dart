import 'dart:async';

import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/anim/page_route.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class ForceNews extends StatefulWidget {
  const ForceNews({
    super.key,
    required this.articleList,
  });

  final List<Article> articleList;

  @override
  State<ForceNews> createState() => _ForceNewsState();
}

class _ForceNewsState extends State<ForceNews> {
  Timer? _timer;
  int index = 0;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (index == widget.articleList.length - 1) {
          index = 0;
        } else {
          index++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        pageRoute(
          child: ArticlePage(article: widget.articleList[index]),
        ),
      ),
      child: Card(
        color: AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: CheckDirect.isRTL(context)
              ? BorderRadius.circular(8)
                  .copyWith(bottomLeft: const Radius.circular(50))
              : BorderRadius.circular(8)
                  .copyWith(bottomRight: const Radius.circular(50)),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5)
              .copyWith(bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.red,
            borderRadius: CheckDirect.isRTL(context)
                ? BorderRadius.circular(8)
                    .copyWith(bottomLeft: const Radius.circular(50))
                : BorderRadius.circular(8)
                    .copyWith(bottomRight: const Radius.circular(50)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  '${'news'.localize(context)}\n${'instant'.localize(context)}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(fontSize: 16, height: 1.25),
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: AppColors.white,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.articleList[index].title,
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(fontSize: 14),
                    ),
                    Text(
                      widget.articleList[index].content.htmlToString(),
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(fontSize: 12),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 70,
                alignment: Alignment.topCenter,
                child: Container(
                  height: 25,
                  width: 25,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.grey200,
                    borderRadius: CheckDirect.isRTL(context)
                        ? BorderRadius.circular(4).copyWith(
                            bottomRight: const Radius.circular(15),
                          )
                        : BorderRadius.circular(4).copyWith(
                            bottomLeft: const Radius.circular(15),
                          ),
                  ),
                  child: const AppIcon(
                    icon: AppIcons.rightArrow,
                    color: AppColors.red,
                    matchDirection: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
