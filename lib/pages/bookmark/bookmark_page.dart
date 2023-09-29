import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TitleWidget(
              title: 'الاخبار المفضل',
              showDivider: true,
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 100),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 5,
              (context, index) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Dismissible(
                  key: UniqueKey(),
                  child: const ArticleWidget(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
