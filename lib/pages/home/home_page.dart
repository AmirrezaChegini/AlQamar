import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/calender/widgets/txt_btn.dart';
import 'package:al_qamar/pages/home/widgets/calender_widget.dart';
import 'package:al_qamar/pages/home/widgets/page_view_item.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              '●احدث الاخبار',
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 14),
            ),
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
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CalenderWidget(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(
                  title: 'قايمة الاخبار',
                  showDivider: true,
                ),
                TxtBtn(
                  onTap: () {},
                  title: 'اقرا اکثرا',
                  icon: AppIcons.leftArrow,
                  ltr: true,
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
}
