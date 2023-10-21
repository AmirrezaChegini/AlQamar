import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/pages/article/widgets/audio_article_player.dart';
import 'package:al_qamar/pages/article/widgets/audio_widget.dart';
import 'package:flutter/material.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({
    super.key,
    required this.article,
  });
  final Article article;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: AudioArticlePlayer(article: article),
          ),
        ),
        SliverToBoxAdapter(
          child: ActionArticle(article: article),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              article.title,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 16),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: article.audios?.length ?? 0,
            (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: AudioWidget(index: index),
            ),
          ),
        ),
      ],
    );
  }
}
