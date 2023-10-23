import 'package:al_qamar/bloc/home/home_bloc.dart';
import 'package:al_qamar/bloc/home/home_event.dart';
import 'package:al_qamar/bloc/home/home_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/pages/home/widgets/calender_widget.dart';
import 'package:al_qamar/pages/home/widgets/force_news.dart';
import 'package:al_qamar/pages/home/widgets/page_view_item.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/error_state.dart';
import 'package:al_qamar/widgets/loading_state.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is CompleteHomeState) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ForceNews(),
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
                    itemCount: 3,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: PageViewItem(article: state.articleList[index]),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CalenderWidget(tabController: tabController),
                ),
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
                      onTap: () {
                        tabController.animateTo(3);
                        BlocProvider.of<BottomnavCubit>(context).changeIndex(3);
                      },
                      title: 'readMore'.localize(context),
                      icon: AppIcons.leftArrow,
                      textDecoration: CheckDirect.isRTL(context)
                          ? TextDirection.ltr
                          : TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 100),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: 1,
                    (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child:
                          ArticleWidget(article: state.articleList[index + 3]),
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
            onTap: () =>
                BlocProvider.of<HomeBloc>(context).add(GetAllDataHomeEvent()),
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
