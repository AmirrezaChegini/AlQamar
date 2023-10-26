import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeArticlePlayer extends StatefulWidget {
  const YoutubeArticlePlayer({
    super.key,
    required this.youtubeID,
  });
  final String? youtubeID;

  @override
  State<YoutubeArticlePlayer> createState() => _YoutubeArticlePlayerState();
}

class _YoutubeArticlePlayerState extends State<YoutubeArticlePlayer>
    with AutomaticKeepAliveClientMixin {
  late final YoutubePlayerController _youtubeCtrl;

  @override
  void initState() {
    super.initState();
    _youtubeCtrl = YoutubePlayerController(
      initialVideoId: widget.youtubeID ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    _youtubeCtrl.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: _youtubeCtrl,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
