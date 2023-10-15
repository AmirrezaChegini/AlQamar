import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/loading_anim.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is CompleteNewsState) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: TitleWidget(
                    title: AppLocalizations.of(context)!.newsList,
                    showDivider: true,
                    dividerWidth: 75,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 100),
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
        } else {
          return const Center(child: LoadingAnim());
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
