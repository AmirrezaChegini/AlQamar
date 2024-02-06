import 'package:al_qamar/bloc/news/news_bloc.dart';
import 'package:al_qamar/bloc/news/news_event.dart';
import 'package:al_qamar/bloc/news/news_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/cubit/hide_fabe_cubit.dart';
import 'package:al_qamar/models/category.dart';
import 'package:al_qamar/widgets/anim/slide_fade_down.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({
    super.key,
    this.category,
  });

  final Category? category;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int page = 1;
  final ScrollController _scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    onInit();
  }

  void onInit() {
    getArticle();

    _scrollCtrl.addListener(() {
      if (_scrollCtrl.position.hasPixels) {
        if (_scrollCtrl.position.pixels ==
            _scrollCtrl.position.maxScrollExtent) {
          ++page;
          getArticle();
          BlocProvider.of<HideFabeCubit>(context).changeVisibility(true);
        } else {
          BlocProvider.of<HideFabeCubit>(context).changeVisibility(false);
        }
      }
    });
  }

  void getArticle() {
    if (widget.category != null) {
      BlocProvider.of<NewsBloc>(context)
          .add(GetArticleByCategoryEVent(widget.category!.id, page));
    } else {
      BlocProvider.of<NewsBloc>(context).add(GetAllArticlesEvent(page));
    }
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: BlocBuilder<HideFabeCubit, bool>(
        builder: (context, state) => SlideFadeDownAnim(
          state: state,
          child: FloatingActionButton(
            onPressed: () {
              if (_scrollCtrl.position.hasPixels) {
                _scrollCtrl.animateTo(
                  0,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeIn,
                );
              }
            },
            backgroundColor: AppColors.blue,
            child: const Icon(Icons.arrow_upward),
          ),
        ),
      ),
      appBar: MainAppbar(
        title: widget.category?.name ?? 'newsList'.localize(context),
        appbarLeading: const BackButton(color: AppColors.red),
      ),
      body: SafeArea(
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is CompleteNewsState) {
              return CustomScrollView(
                controller: _scrollCtrl,
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
                        child: ArticleWidget(
                          article: state.articleList[index],
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

            if (state is EmptyNewsState) {
              return Center(child: Image.asset(AppImages.blank));
            }

            if (state is FailNewsState) {
              return ErrorState(
                errorMessage: state.errorMessage,
                onTap: onInit,
                width: double.infinity,
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
