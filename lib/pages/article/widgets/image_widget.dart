import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:al_qamar/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({
    super.key,
    required this.article,
  });
  final Article article;

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height / 3,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                PageView.builder(
                  itemCount: widget.article.images?.length ?? 1,
                  controller: _pageController,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CacheImage(
                        imageUrl:
                            widget.article.images?[index] ?? AppImages.error,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  child: SmoothPageIndicator(
                    controller: _pageController,
                    count: widget.article.images?.length ?? 1,
                    effect: const ExpandingDotsEffect(
                      dotColor: AppColors.grey,
                      activeDotColor: AppColors.white,
                      dotHeight: 6,
                      dotWidth: 6,
                      expansionFactor: 5,
                      spacing: 6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ActionArticle(article: widget.article),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.article.title,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 16),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.article.content,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontSize: 14),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: TitleWidget(
              title: 'similarNews'.localize(context),
              dividerWidth: 80,
              showDivider: true,
            ),
          ),
        ),
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     childCount: articleList.length,
        //     (context, index) => Padding(
        //       padding: const EdgeInsets.all(10),
        //       child: ArticleWidget(article: articleList[index]),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
