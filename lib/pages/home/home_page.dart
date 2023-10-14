import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/bottomnav_cubit.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/pages/home/widgets/calender_widget.dart';
import 'package:al_qamar/pages/home/widgets/force_news.dart';
import 'package:al_qamar/pages/home/widgets/page_view_item.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TitleWidget(
                title: '● ${AppLocalizations.of(context)!.latestNews}'),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3.5,
            child: PageView.builder(
              itemCount: 3,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: PageViewItem(),
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
                  title: AppLocalizations.of(context)!.newsList,
                  showDivider: true,
                  dividerWidth: 75,
                ),
              ),
              TxtBtn(
                onTap: () {
                  tabController.animateTo(3);
                  BlocProvider.of<BottomnavCubit>(context).changeIndex(3);
                },
                title: AppLocalizations.of(context)!.readMore,
                icon: AppIcons.leftArrow,
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: ArticleWidget(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
