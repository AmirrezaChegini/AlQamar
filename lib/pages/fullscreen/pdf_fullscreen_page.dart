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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.bottom,
        SystemUiOverlay.top,
      ],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SfPdfViewer.network(
      widget.pdf,
      controller: _pdfCtrl,
      pageSpacing: 0,
      canShowPageLoadingIndicator: false,
      pageLayoutMode: PdfPageLayoutMode.continuous,
    );
  }
}
