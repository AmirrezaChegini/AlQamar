import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/search/widgets/textfield_search.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final List<Article> articleList = const [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          const TextfielfSearch(),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: Divider(),
              ),
              Text.rich(
                TextSpan(
                    text:
                        '${'about'.localize(context)} 1202 ${'result'.localize(context)}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 12),
                    children: [
                      TextSpan(
                        text: ' "النص المطلوب"',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ]),
              ),
              const Expanded(
                flex: 9,
                child: Divider(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: articleList.length,
              controller: scrollController,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ArticleWidget(
                  article: articleList[index],
                  backgroundColor: AppColors.grey200,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
