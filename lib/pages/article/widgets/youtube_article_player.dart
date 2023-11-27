import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeArticlePlayer extends StatefulWidget {
  const YoutubeArticlePlayer({
    super.key,
    required this.youtubeID,
  });
  final String youtubeID;

  @override
  State<YoutubeArticlePlayer> createState() => _YoutubeArticlePlayerState();
}

class _YoutubeArticlePlayerState extends State<YoutubeArticlePlayer> {
  late final YoutubePlayerController _playerCtrl;

  @override
  void initState() {
    super.initState();
    _playerCtrl = YoutubePlayerController()..loadVideo(widget.youtubeID);
  }

  @override
  void dispose() {
    _playerCtrl.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: YoutubePlayer(
          controller: _playerCtrl,
          aspectRatio: 16 / 9,
          backgroundColor: AppColors.transparent,
        ),
      ),
    );
  }
}
