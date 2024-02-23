import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        title: 'favorite'.localize(context),
        appbarLeading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: AppColors.red,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 0,
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ArticleWidget(
                      article: Article(
                        '',
                        '',
                        '',
                        false,
                        '',
                        '',
                        '',
                        null,
                        '',
                        '',
                        [],
                        [],
                        [],
                        [],
                        null,
                        null,
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
