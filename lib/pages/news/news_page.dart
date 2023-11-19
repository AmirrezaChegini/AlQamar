import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.pixels == _scrollCtrl.position.maxScrollExtent) {
        BlocProvider.of<NewsBloc>(context).add(GetAllArticlesEvent());
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<NewsBloc, NewsState>(
      listener: (context, state) {
        if (state is FailNewsState) {
          showMessage(
            context: context,
            content: state.errorMessage.localize(context),
            verticalMargin: 0,
            horizontalMargin: 10,
          );
        }
      },
      builder: (context, state) {
        if (state is CompleteNewsState) {
          return CustomScrollView(
            controller: _scrollCtrl,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TitleWidget(
                    title: 'newsList'.localize(context),
                    showDivider: true,
                    dividerWidth: 75,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 110),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.articleList.length,
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: ArticleWidget(article: state.articleList[index]),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (state is LoadingNewsState) {
          return const LoadingState();
        }

        return const SizedBox();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
