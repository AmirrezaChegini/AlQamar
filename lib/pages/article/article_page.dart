import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/article_cubit.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/pages/article/widgets/article_tabbar.dart';
import 'package:al_qamar/pages/article/widgets/audio_article_player.dart';
import 'package:al_qamar/pages/article/widgets/audio_widget.dart';
import 'package:al_qamar/pages/article/widgets/image_viewer.dart';
import 'package:al_qamar/pages/article/widgets/pdf_article_viewer.dart';
import 'package:al_qamar/pages/article/widgets/pdf_item_widget.dart';
import 'package:al_qamar/pages/article/widgets/video_article_player.dart';
import 'package:al_qamar/pages/article/widgets/youtube_article_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    super.key,
    required this.article,
  });
  final Article article;

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;
  late final List<String> _tabsText;
  final List<String> _tabsIcon = const [
    AppIcons.image,
    AppIcons.video,
    AppIcons.youtube,
    AppIcons.audio,
    AppIcons.pdf
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tabsText = [
      'photo'.localize(context),
      'video'.localize(context),
      'youtube'.localize(context),
      'audio'.localize(context),
      'document'.localize(context),
    ];
  }

  @override
  void dispose() {
    _tabCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: ArticleTabbar(
        tabController: _tabCtrl,
        tabsIcon: _tabsIcon,
        tabsText: _tabsText,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 2.9,
              child: TabBarView(
                controller: _tabCtrl,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ImageViewer(images: widget.article.images),
                  VideoArticlePlayer(video: widget.article.videos?[0]),
                  YoutubeArticlePlayer(youtubeID: widget.article.youtube),
                  AudioArticlePlayer(article: widget.article),
                  PdfArticleViewer(pdfList: widget.article.pdfs),
                ],
              ),
            ),
          ),
          BlocBuilder<ArticleCubit, int>(
            builder: (context, state) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state == 3
                      ? widget.article.audios?.length ?? 0
                      : state == 4
                          ? widget.article.pdfs?.length ?? 0
                          : 0,
                  (context, index) => Padding(
                    padding: const EdgeInsets.all(10).copyWith(bottom: 20),
                    child: state == 3
                        ? AudioWidget(index: index)
                        : state == 4
                            ? PdfItemWidget(index: index)
                            : const SizedBox(),
                  ),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: ActionArticle(article: widget.article),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.article.title,
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
                widget.article.content,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
