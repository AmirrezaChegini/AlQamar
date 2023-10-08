import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/search/widgets/textfield_search.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

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
                    text: 'حوالی 1202 نتیجه',
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
              itemCount: 6,
              controller: scrollController,
              itemBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: ArticleWidget(
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
