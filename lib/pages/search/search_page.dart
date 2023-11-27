import 'package:al_qamar/bloc/search/search_bloc.dart';
import 'package:al_qamar/bloc/search/search_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/search/widgets/textfield_search.dart';
import 'package:al_qamar/widgets/article_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Article> articleList = [];
  final TextEditingController _edtCtrl = TextEditingController();

  @override
  void dispose() {
    _edtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20)
          .copyWith(bottom: 0),
      decoration: const BoxDecoration(
        color: AppColors.grey200,
      ),
      child: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is CompleteSearchState) {
            articleList = state.articleList;
          }
        },
        builder: (context, state) => Column(
          children: [
            const SizedBox(height: 15),
            TextfielfSearch(edtCtrl: _edtCtrl),
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
                          '${'about'.localize(context)} ${articleList.length} ${'result'.localize(context)}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                      children: [
                        TextSpan(
                          text: ' "${_edtCtrl.text}"',
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
                controller: widget.scrollController,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ArticleWidget(
                    article: articleList[index],
                    // backgroundColor: AppColors.grey200,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
