import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/pages/article/widgets/video_article_player.dart';
import 'package:flutter/material.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({
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
            height: article.videos != null
                ? MediaQuery.sizeOf(context).height / 3
                : 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: VideoArticlePlayer(video: article.videos?[0]),
            ),
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              article.content,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
