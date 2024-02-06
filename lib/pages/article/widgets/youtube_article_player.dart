import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

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
  // late final YoutubePlayerController _playerCtrl;
  late final PodPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.youtubeID),
    )..initialise();
    // _playerCtrl = YoutubePlayerController(
    //   params: const YoutubePlayerParams(),
    // )..loadVideo(widget.youtubeID);
  }

  @override
  void dispose() {
    // _playerCtrl.close();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ColoredBox(
          color: AppColors.black,
          child: PodVideoPlayer(
            controller: _controller,
            podProgressBarConfig: const PodProgressBarConfig(
              padding: EdgeInsets.only(top: 0, right: 15, left: 15, bottom: 4),
              height: 2,
            ),
          ),
        ),
        // child: YoutubePlayer(
        //   controller: _playerCtrl,
        //   aspectRatio: 16 / 9,
        //   backgroundColor: AppColors.transparent,
        // ),
      ),
    );
  }
}
