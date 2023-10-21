import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/pages/article/widgets/pdf_article_viewer.dart';
import 'package:al_qamar/pages/article/widgets/pdf_item_widget.dart';
import 'package:flutter/material.dart';

class PdfPage extends StatelessWidget {
  const PdfPage({
    super.key,
    required this.article,
  });
  final Article article;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: MediaQuery.sizeOf(context).height / 3,
            margin: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: PdfArticleViewer(pdfList: article.pdfs),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ActionArticle(article: article),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              article.title,
              maxLines: 3,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 16),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: article.pdfs?.length ?? 0,
            (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: PdfItemWidget(index: index),
            ),
          ),
        ),
      ],
    );
  }
}
