import 'package:al_qamar/bloc/article/article_bloc.dart';
import 'package:al_qamar/bloc/article/article_event.dart';
import 'package:al_qamar/bloc/article/article_state.dart';
import 'package:al_qamar/bloc/download/download_bloc.dart';
import 'package:al_qamar/bloc/other_article/other_article_bloc.dart';
import 'package:al_qamar/bloc/other_article/other_article_event.dart';
import 'package:al_qamar/bloc/other_article/other_article_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/article_cubit.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/pages/article/widgets/article_appbar.dart';
import 'package:al_qamar/pages/article/widgets/audio_article_player.dart';
import 'package:al_qamar/pages/article/widgets/audio_widget.dart';
import 'package:al_qamar/pages/article/widgets/image_viewer.dart';
import 'package:al_qamar/pages/article/widgets/pdf_article_viewer.dart';
import 'package:al_qamar/pages/article/widgets/pdf_item_widget.dart';
import 'package:al_qamar/pages/article/widgets/video_article_player.dart';
import 'package:al_qamar/pages/article/widgets/youtube_article_player.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/html_viewer.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({
    super.key,
    required this.articleID,
  });
  final String articleID;

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
    BlocProvider.of<ArticleBloc>(context)
        .add(GetArticleEvent(widget.articleID));
    BlocProvider.of<OtherArticleBloc>(context).add(GetOtherArticleEvent());
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is CompleteArticleState) {
          return Scaffold(
            appBar: ArticleAppbar(
              article: state.article,
              tabController: _tabCtrl,
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height < 800
                        ? MediaQuery.sizeOf(context).height / 2.2
                        : MediaQuery.sizeOf(context).height / 3,
                    child: Stack(
                      children: [
                        Container(
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
                        TabBarView(
                          controller: _tabCtrl,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ImageViewer(images: state.article.images),
                            VideoArticlePlayer(
                              video: state.article.videos.isNotEmpty
                                  ? state.article.videos
                                  : [],
                            ),
                            YoutubeArticlePlayer(
                                youtubeID: state.article.youtube),
                            AudioArticlePlayer(
                              audios: state.article.audios,
                              date: state.article.updated,
                              image: state.article.images.isNotEmpty
                                  ? state.article.images[0]
                                  : AppImages.error,
                              writer: state.article.writer.name,
                            ),
                            PdfArticleViewer(pdfList: state.article.pdfs),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<ArticleCubit, int>(
                  builder: (context, innerState) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: innerState == 3
                            ? state.article.audios.length
                            : innerState == 4
                                ? state.article.pdfs.length
                                : 0,
                        (context, index) => Padding(
                          padding: const EdgeInsets.all(10),
                          child: innerState == 3
                              ? BlocProvider(
                                  create: (context) =>
                                      locator.get<DownloadAudioBloc>(),
                                  child: AudioWidget(
                                    index: index,
                                    audio: state.article.audios[index],
                                    image: state.article.images.isNotEmpty
                                        ? state.article.images[0]
                                        : '',
                                  ),
                                )
                              : innerState == 4
                                  ? BlocProvider(
                                      create: (context) =>
                                          locator.get<DownloadPdfBloc>(),
                                      child: PdfItemWidget(
                                        index: index,
                                        url: state.article.pdfs[index],
                                      ),
                                    )
                                  : const SizedBox(),
                        ),
                      ),
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: ActionArticle(article: state.article),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: HtmlViewer(
                    content: state.article.content,
                    renderMode: RenderMode.sliverList,
                  ),
                ),
                BlocBuilder<OtherArticleBloc, OtherArticleState>(
                  builder: (context, state) {
                    if (state is CompleteOtherArticleState) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: TitleWidget(
                            title: 'otherNews'.localize(context),
                            showDivider: true,
                            dividerWidth: 60,
                          ),
                        ),
                      );
                    }
                    return const SliverToBoxAdapter();
                  },
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
          );
        }

        if (state is LoadingArticleState) {
          return const Scaffold(
            body: Center(
              child: LoadingState(),
            ),
          );
        }

        if (state is FailedArticleState) {
          return Scaffold(
            body: Center(
              child: ErrorState(
                errorMessage: state.errorMessage,
                onTap: () => BlocProvider.of<ArticleBloc>(context).add(
                  GetArticleEvent(widget.articleID),
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
