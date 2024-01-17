import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/category.dart';
import 'package:al_qamar/widgets/anim/fade_in_staggered.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context)
        .add(GetAllArticlesEvent(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: widget.category.name,
        appbarLeading: const BackButton(color: AppColors.red),
      ),
      body: SafeArea(
        child: BlocConsumer<NewsBloc, NewsState>(
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
                slivers: [
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: TitleWidget(
                  //       title: 'newsList'.localize(context),
                  //       showDivider: true,
                  //       dividerWidth: 75,
                  //     ),
                  //   ),
                  // ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.articleList.length,
                      (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        child: FadeInStaggeredAnim(
                          duration: Duration(milliseconds: index * 100),
                          child: ArticleWidget(
                            article: state.articleList[index],
                          ),
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
        ),
      ),
    );
  }
}
