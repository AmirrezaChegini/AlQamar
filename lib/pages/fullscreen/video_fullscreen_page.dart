import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/utils/anim/fade_in_out.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoFullscrreenPage extends StatefulWidget {
  const VideoFullscrreenPage({
    super.key,
    required this.videoCtrl,
  });

  final VideoPlayerController videoCtrl;

  @override
  State<VideoFullscrreenPage> createState() => _VideoFullscrreenPageState();
}

class _VideoFullscrreenPageState extends State<VideoFullscrreenPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.videoCtrl.value.aspectRatio,
      child: GestureDetector(
        onDoubleTap: () => widget.videoCtrl,
        onTap: () => setState(() {
          if (widget.videoCtrl.value.isPlaying) {
            widget.videoCtrl.pause();
          } else {
            widget.videoCtrl.play();
          }
        }),
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(widget.videoCtrl),
            FadeOutAnim(
              state: widget.videoCtrl.value.isPlaying,
              child: widget.videoCtrl.value.isPlaying
                  ? const Icon(
                      Icons.pause_rounded,
                      color: AppColors.white,
                      size: 80,
                    )
                  : const Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.white,
                      size: 80,
                    ),
            ),
            Positioned.directional(
              textDirection: CheckDirect.isRTL(context)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              bottom: 0,
              start: 20,
              child: FadeOutAnim(
                state: widget.videoCtrl.value.isPlaying,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.fullscreen_exit_rounded,
                    color: AppColors.white,
                    size: 80,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
