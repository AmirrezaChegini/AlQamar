import 'package:al_qamar/constants/colors.dart';
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
      backgroundColor: AppColors.grey200,
      appBar: const MainAppbar(title: 'المفضلة', showLeading: false),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // const SliverToBoxAdapter(
            //   child: Padding(
            //     padding: EdgeInsets.all(10),
            //     child: TitleWidget(
            //       title: 'الاخبار المفضل',
            //       showDivider: true,
            //       dividerWidth: 85,
            //     ),
            //   ),
            // ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 5,
                  (context, index) => Dismissible(
                    key: UniqueKey(),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: ArticleWidget(),
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
