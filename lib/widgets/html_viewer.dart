import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class HtmlViewer extends StatelessWidget {
  const HtmlViewer({
    super.key,
    required this.content,
    this.renderMode = RenderMode.column,
  });

  final String content;
  final RenderMode renderMode;

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      content,
      renderMode: renderMode,
    );
  }
}
