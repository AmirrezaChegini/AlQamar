import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfFullscreenPage extends StatefulWidget {
  const PdfFullscreenPage({
    super.key,
    required this.pdf,
  });

  final String pdf;

  @override
  State<PdfFullscreenPage> createState() => _PdfFullscreenPageState();
}

class _PdfFullscreenPageState extends State<PdfFullscreenPage> {
  final PdfViewerController _pdfCtrl = PdfViewerController();
  PdfTextSearchResult _searchResult = PdfTextSearchResult();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _pdfCtrl.dispose();
    _searchResult.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          leading: const Icon(
            Icons.search,
            color: AppColors.black,
          ),
          actions: [
            Align(
              alignment: Alignment.center,
              child: Text(
                '${_searchResult.totalInstanceCount}'.toArabic(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: Fontsize.huge),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '/',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: Fontsize.huge),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                '${_searchResult.currentInstanceIndex}'.toArabic(),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: Fontsize.huge),
              ),
            ),
            IconButton(
              onPressed: () => _searchResult.nextInstance(),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.black,
                size: 30,
              ),
            ),
            IconButton(
              onPressed: () => _searchResult.previousInstance(),
              icon: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: AppColors.black,
                size: 30,
              ),
            ),
          ],
          title: TextField(
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: Fontsize.huge),
            onChanged: (value) {
              if (value.isEmpty) {
                _searchResult.clear();
              }
            },
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                _searchResult = _pdfCtrl.searchText(value);
                _searchResult.addListener(() {
                  if (_searchResult.hasResult) {
                    setState(() {});
                  }
                });
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'بحث في النص',
              hintStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: Fontsize.large),
            ),
          ),
        ),
        body: SfPdfViewer.network(
          widget.pdf,
          controller: _pdfCtrl,
          pageSpacing: 0,
          canShowPageLoadingIndicator: false,
          pageLayoutMode: PdfPageLayoutMode.continuous,
        ),
      ),
    );
  }
}
