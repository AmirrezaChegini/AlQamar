import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 4,
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FittedBox(
                      child: Text(
                        'الاخبار المفضل',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      endIndent: 0,
                      indent: 0,
                      color: AppColors.blue,
                    )
                  ],
                ),
              )
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
