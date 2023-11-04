import 'package:al_qamar/bloc/bookmark/bookmark_bloc.dart';
import 'package:al_qamar/bloc/bookmark/bookmark_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
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
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/html_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

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

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this);
    BlocProvider.of<ArticleCubit>(context).changeIndex(0);
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
      appBar: ArticleTabbar(tabController: _tabCtrl),
      body: BlocListener<BookmarkBloc, BookmarkState>(
        listener: (context, state) {
          if (state is FailBookmarkState) {
            showMessage(
              context: context,
              content: state.errorMessage.localize(context),
              horizontalMargin: 10,
              verticalMargin: 10,
            );
          }

          if (state is CompleteRemoveBookmarkState) {
            showMessage(
              context: context,
              content: state.message,
              horizontalMargin: 10,
              verticalMargin: 10,
            );
          }

          if (state is CompleteAddBookmarkState) {
            showMessage(
              context: context,
              content: state.message,
              horizontalMargin: 10,
              verticalMargin: 10,
            );
          }
        },
        child: CustomScrollView(
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
                    VideoArticlePlayer(
                      video: widget.article.videos.isNotEmpty
                          ? widget.article.videos[0]
                          : '',
                    ),
                    YoutubeArticlePlayer(youtubeID: widget.article.youtube),
                    AudioArticlePlayer(
                      audios: widget.article.audios,
                      date: widget.article.updateAt,
                      image: widget.article.images.isNotEmpty
                          ? widget.article.images[0]
                          : AppImages.error,
                      writer: widget.article.writer,
                    ),
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
                        ? widget.article.audios.length
                        : state == 4
                            ? widget.article.pdfs.length
                            : 0,
                    (context, index) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: state == 3
                          ? AudioWidget(
                              index: index,
                              audio: widget.article.audios[index],
                              image: widget.article.images.isNotEmpty
                                  ? widget.article.images[0]
                                  : '',
                            )
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
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: HtmlViewer(
                content: widget.article.content,
                renderMode: RenderMode.sliverList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
