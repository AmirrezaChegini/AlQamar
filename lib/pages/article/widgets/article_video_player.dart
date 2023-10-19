import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/utils/anim/fade_in_out.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ArticleVideoPlayer extends StatefulWidget {
  const ArticleVideoPlayer({
    super.key,
    this.video = '',
  });

  final String video;

  @override
  State<ArticleVideoPlayer> createState() => _ArticleVideoPlayerState();
}

class _ArticleVideoPlayerState extends State<ArticleVideoPlayer> {
  late final VideoPlayerController _videoPlayerController;
  bool state = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video),
    )..initialize().then((value) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: _videoPlayerController.value.size.width,
          minWidth: _videoPlayerController.value.size.width,
          maxHeight: _videoPlayerController.value.size.height,
          minHeight: _videoPlayerController.value.size.height,
        ),
        child: AspectRatio(
          aspectRatio: _videoPlayerController.value.aspectRatio,
          child: GestureDetector(
            onDoubleTap: () => _videoPlayerController,
            onTap: () => setState(() {
              if (_videoPlayerController.value.isPlaying) {
                _videoPlayerController.pause();
              } else {
                _videoPlayerController.play();
              }
              if (state) {
                state = false;
              } else {
                state = true;
              }
            }),
            child: Stack(
              alignment: Alignment.center,
              children: [
                VideoPlayer(_videoPlayerController),
                FadeOutAnim(
                  state: state,
                  child: _videoPlayerController.value.isPlaying
                      ? const Icon(
                          Icons.pause_rounded,
                          color: AppColors.grey,
                          size: 200,
                        )
                      : const Icon(
                          Icons.play_arrow_rounded,
                          color: AppColors.grey,
                          size: 200,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
