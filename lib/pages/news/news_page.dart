import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/search/search_page.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';

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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(
                  title: 'قايمة الاخبار',
                  showDivider: true,
                ),
                IconButton(
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      elevation: 30,
                      backgroundColor: AppColors.transparent,
                      builder: (context) => const SearchPage(),
                    );
                  },
                  icon: const SvgIcon(
                    icon: AppIcons.search,
                    color: AppColors.blue,
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
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

  @override
  bool get wantKeepAlive => true;
}
