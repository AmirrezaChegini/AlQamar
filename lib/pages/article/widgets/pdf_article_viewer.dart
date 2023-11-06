import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/pdf_cubit.dart';
import 'package:al_qamar/pages/fullscreen/pdf_fullscreen.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfArticleViewer extends StatefulWidget {
  const PdfArticleViewer({
    super.key,
    required this.pdfList,
  });
  final List<dynamic> pdfList;

  @override
  State<PdfArticleViewer> createState() => _PdfArticleViewerState();
}

class _PdfArticleViewerState extends State<PdfArticleViewer>
    with AutomaticKeepAliveClientMixin {
  final PdfViewerController _pdfCtrl = PdfViewerController();

  @override
  void dispose() {
    _pdfCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.pdfList.isNotEmpty) {
      return BlocBuilder<PdfCubit, int>(
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                SfPdfViewer.network(
                  widget.pdfList[state],
                  controller: _pdfCtrl,
                  pageSpacing: 0,
                  canShowPageLoadingIndicator: false,
                  pageLayoutMode: PdfPageLayoutMode.continuous,
                ),
                Positioned.directional(
                  textDirection: CheckDirect.isRTL(context)
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  bottom: 0,
                  start: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      fadePageTran(
                        child: PdfFullscreenPage(
                            pdfCtrl: _pdfCtrl, pdf: widget.pdfList[state]),
                      ),
                    ),
                    child: const Icon(
                      Icons.fullscreen_rounded,
                      size: 50,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(70),
          child: AppIcon(
            icon: AppIcons.pdf,
            color: AppColors.grey600,
          ),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
