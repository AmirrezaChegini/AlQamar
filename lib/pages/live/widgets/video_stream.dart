import 'package:al_qamar/cubit/live_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({
    super.key,
    required this.url,
  });

  final String url;

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  late final WebViewController _webCtrl;

  @override
  void initState() {
    super.initState();

    _webCtrl = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: double.infinity,
        minWidth: double.infinity,
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: BlocConsumer<LiveCubit, String>(
          listener: (context, state) {
            _webCtrl
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..enableZoom(true)
              ..loadRequest(Uri.parse(state));
          },
          builder: (context, state) => WebViewWidget(
            controller: _webCtrl,
          ),
        ),
      ),
    );
  }
}
