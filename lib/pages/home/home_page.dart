import 'dart:async';

import 'package:al_qamar/bloc/azan/azan_bloc.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/article/article_page.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/pages/home/widgets/calender_widget.dart';
import 'package:al_qamar/pages/home/widgets/force_news.dart';
import 'package:al_qamar/pages/home/widgets/page_view_item.dart';
import 'package:al_qamar/pages/news/news_page.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/anim/page_route.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/azan_widget.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageCtrl = PageController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    changeArticlesAuto();
  }

  void changeArticlesAuto() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_pageCtrl.page == 2) {
        _pageCtrl.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      } else {
        _pageCtrl.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CompleteHomeState) {
          return CustomScrollView(
            slivers: [
              if (state.forceArticleList.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ForceNews(articleList: state.forceArticleList),
                  ),
                ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child:
                      TitleWidget(title: '● ${'latestNews'.localize(context)}'),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: PageView.builder(
                    itemCount: state.lastArticleList.length < 3
                        ? state.lastArticleList.length
                        : 3,
                    controller: _pageCtrl,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10).copyWith(top: 0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          pageRoute(
                            child: ArticlePage(
                              article: state.lastArticleList[index],
                            ),
                          ),
                        ),
                        onLongPressStart: (details) => _timer?.cancel(),
                        onLongPressEnd: (details) => changeArticlesAuto(),
                        child: PageViewItem(
                          article: state.lastArticleList[index],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CalenderWidget(tabController: widget.tabController),
                ),
              ),
              BlocBuilder<AzanBloc, AzanState>(
                builder: (context, state) {
                  if (state is CompletedAzanState) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: List.generate(
                          state.azanTimeList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: AzanWidget(
                              city: index == 0
                                  ? 'najaf'.localize(context)
                                  : 'london'.localize(context),
                              azanTime: state.azanTimeList[index],
                              elevation: 4,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter();
                },
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TitleWidget(
                        title: 'newsList'.localize(context),
                        showDivider: true,
                        dividerWidth: 75,
                      ),
                    ),
                    TxtBtn(
                      onTap: () => Navigator.push(
                        context,
                        pageRoute(child: const NewsPage()),
                      ),
                      title: 'readMore'.localize(context),
                      icon: AppIcons.leftArrow,
                      textDecoration: CheckDirect.isRTL(context)
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                      fontSize: Fontsize.large,
                      iconSize: 20,
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 110),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.lastArticleList.length - 3,
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: ArticleWidget(
                          article: state.lastArticleList[index + 3]),
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        if (state is FailHomeState) {
          return ErrorState(
            errorMessage: state.errorMessage,
            onTap: () => BlocProvider.of<HomeBloc>(context).add(GetHomeEvent()),
          );
        }

        if (state is LoadingHomeState) {
          return const LoadingState();
        }

        return const SizedBox();
      },
    );
  }
}
