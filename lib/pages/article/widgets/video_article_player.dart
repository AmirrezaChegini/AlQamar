import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/utils/anim/fade_in_out.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoArticlePlayer extends StatefulWidget {
  const VideoArticlePlayer({
    super.key,
    this.video,
  });
  final String? video;
  @override
  State<VideoArticlePlayer> createState() => _VideoArticlePlayerState();
}

class _VideoArticlePlayerState extends State<VideoArticlePlayer>
    with AutomaticKeepAliveClientMixin {
  late final VideoPlayerController _videoCtrl;

  @override
  void initState() {
    super.initState();
    _videoCtrl = VideoPlayerController.networkUrl(
      Uri.parse(widget.video ?? ''),
    )..initialize().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    _videoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.video != null) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: _videoCtrl.value.size.width,
                minWidth: _videoCtrl.value.size.width,
                maxHeight: _videoCtrl.value.size.height,
                minHeight: _videoCtrl.value.size.height,
              ),
              child: AspectRatio(
                aspectRatio: _videoCtrl.value.aspectRatio,
                child: GestureDetector(
                  onDoubleTap: () => _videoCtrl,
                  onTap: () => setState(() {
                    if (_videoCtrl.value.isPlaying) {
                      _videoCtrl.pause();
                    } else {
                      _videoCtrl.play();
                    }
                  }),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      VideoPlayer(_videoCtrl),
                      FadeOutAnim(
                        state: _videoCtrl.value.isPlaying,
                        child: _videoCtrl.value.isPlaying
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
          ),
        ),
      );
    } else {
      return const Center(
        child: AppIcon(
          icon: AppIcons.videoError,
          color: AppColors.grey600,
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
