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
  late final PodPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(widget.youtubeID),
    )..initialise();
  }

  @override
  void dispose() {
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
      ),
    );
  }
}
