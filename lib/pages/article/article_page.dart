import 'package:al_qamar/bloc/download/download_bloc.dart';
import 'package:al_qamar/bloc/favorite/favorite_bloc.dart';
import 'package:al_qamar/bloc/favorite/favorite_event.dart';
import 'package:al_qamar/bloc/other_article/other_article_bloc.dart';
import 'package:al_qamar/bloc/other_article/other_article_event.dart';
import 'package:al_qamar/bloc/other_article/other_article_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/article_cubit.dart';
import 'package:al_qamar/cubit/bookmark_cubit.dart';
import 'package:al_qamar/di.dart';
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
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/html_viewer.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/title_widget.dart';
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
  final GlobalKey _globalKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 5, vsync: this);
    BlocProvider.of<ArticleCubit>(context).changeIndex(0);
    BlocProvider.of<FavoriteBloc>(context).add(GetFavorite(widget.article));
    BlocProvider.of<BookmarkCubit>(context).isBookmark(widget.article);
    BlocProvider.of<OtherArticleBloc>(context).add(InitOtherArticleEvent());
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (BlocProvider.of<OtherArticleBloc>(context).state
            is! CompleteOtherArticleState) {
          BlocProvider.of<OtherArticleBloc>(context)
              .add(GetOtherArticleEvent());
        }
      }
    });
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  double getPosition() {
    RenderBox box = _globalKey.currentContext?.findRenderObject() as RenderBox;
    Offset posistion = box.localToGlobal(Offset.zero);
    return posistion.dy;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: ArticleTabbar(
        tabController: _tabCtrl,
        audios: widget.article.audios,
        videos: widget.article.videos,
        pdfs: widget.article.pdfs,
        youtube: widget.article.youtube,
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) => [
          SliverAppBar.large(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            floating: true,
            pinned: false,
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.sizeOf(context).height / 3,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(0),
              expandedTitleScale: 1,
              background: Container(
                margin: const EdgeInsets.only(bottom: 50),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.grey600,
                      AppColors.grey200,
                    ],
                  ),
                ),
              ),
              title: SizedBox(
                width: double.infinity,
                height: MediaQuery.sizeOf(context).height < 800
                    ? MediaQuery.sizeOf(context).height / 2.2
                    : MediaQuery.sizeOf(context).height / 3,
                child: TabBarView(
                  controller: _tabCtrl,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ImageViewer(images: widget.article.images),
                    VideoArticlePlayer(
                      video: widget.article.videos.isNotEmpty
                          ? widget.article.videos
                          : [],
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
          ),
        ],
        body: CustomScrollView(
          slivers: [
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
                          ? BlocProvider(
                              create: (context) => locator.get<DownloadBloc>(),
                              child: AudioWidget(
                                index: index,
                                audio: widget.article.audios[index],
                                image: widget.article.images.isNotEmpty
                                    ? widget.article.images[0]
                                    : '',
                              ),
                            )
                          : state == 4
                              ? BlocProvider(
                                  create: (context) =>
                                      locator.get<DownloadBloc>(),
                                  child: PdfItemWidget(
                                    index: index,
                                    url: widget.article.pdfs[index],
                                  ),
                                )
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
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(60),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      AppColors.red.withOpacity(0.4),
                      AppColors.grey200,
                    ],
                  ),
                ),
                child: Text(
                  widget.article.title,
                  maxLines: 3,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 14),
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: TitleWidget(
                  key: _globalKey,
                  title: 'otherNews'.localize(context),
                  showDivider: true,
                  dividerWidth: 60,
                ),
              ),
            ),
            BlocBuilder<OtherArticleBloc, OtherArticleState>(
              builder: (context, state) {
                if (state is LoadingOtherArticleState) {
                  return const SliverToBoxAdapter(
                    child: LoadingState(),
                  );
                }

                if (state is CompleteOtherArticleState) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.articleList.length < 5
                          ? state.articleList.length
                          : 5,
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10,
                        ),
                        child: ArticleWidget(
                          article: state.articleList[index],
                        ),
                      ),
                    ),
                  );
                }

                return const SliverToBoxAdapter();
              },
            )
          ],
        ),
      ),
    );
  }
}
