import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/models/calender.dart';
import 'package:al_qamar/pages/article/widgets/article_tabbar.dart';
import 'package:flutter/material.dart';

class ArticleAppbar extends StatelessWidget implements PreferredSizeWidget {
  const ArticleAppbar({
    super.key,
    this.article,
    this.calender,
    required this.tabController,
  });

  final Article? article;
  final Calender? calender;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue,
      elevation: 0,
      centerTitle: true,
      title: Text(
        article != null ? article?.title ?? '' : calender?.title ?? '',
        maxLines: 2,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(fontSize: Fontsize.big),
      ),
      bottom: ArticleTabbar(
        tabController: tabController,
        audios:
            article != null ? article?.audios ?? [] : calender?.audios ?? [],
        videos:
            article != null ? article?.videos ?? [] : calender?.videos ?? [],
        pdfs: article != null ? article?.pdfs ?? [] : calender?.pdfs ?? [],
        youtube:
            article != null ? article?.youtube ?? '' : calender?.youtube ?? '',
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(140);
}
