import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/article/widgets/action_article.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfWidget extends StatefulWidget {
  const PdfWidget({
    super.key,
  });

  @override
  State<PdfWidget> createState() => _PdfWidgetState();
}

class _PdfWidgetState extends State<PdfWidget> {
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
              child: SfPdfViewer.network(
                'https://www.parsipdf.ir/files/sample-1.pdf',
                pageSpacing: 0,
                canShowPageLoadingIndicator: false,
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: ActionArticle(),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'التمهدیة الأولی اللحزب الجمهوری فی الدورة الانتخابیة',
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
            childCount: 5,
            (context, index) => Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {},
                selected: false,
                tileColor: AppColors.white,
                selectedTileColor: AppColors.red100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                leading: SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AppIcon(
                        icon: AppIcons.pdf,
                        width: 30,
                        height: 30,
                        color: AppColors.black,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'الجزء الأول',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 16),
                          ),
                          Text(
                            '123.6 MB',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 13),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
