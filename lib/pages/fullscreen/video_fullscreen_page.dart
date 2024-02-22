import 'dart:async';

import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/anim/animated_icon.dart';
import 'package:al_qamar/widgets/anim/fade_in.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
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
  bool isPlaying = false;
  double volume = 0;
  double duration = 1;
  double position = 0;
  bool showControler = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        isPlaying = widget.videoCtrl.value.isPlaying;
        volume = widget.videoCtrl.value.volume;
        duration = widget.videoCtrl.value.duration.inMilliseconds.toDouble();
        position = widget.videoCtrl.value.position.inMilliseconds.toDouble();
        if (position == duration - 1) {
          widget.videoCtrl.pause();
        }
        if (widget.videoCtrl.value.isCompleted) {
          showControler = true;
        }
      });
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            setState(() {
              showControler = !showControler;
            });
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: widget.videoCtrl.value.size.width,
                      minWidth: widget.videoCtrl.value.size.width,
                      maxHeight: widget.videoCtrl.value.size.height,
                      minHeight: widget.videoCtrl.value.size.height,
                    ),
                    child: AspectRatio(
                      aspectRatio: widget.videoCtrl.value.aspectRatio,
                      child: GestureDetector(
                        onTap: () {},
                        child: VideoPlayer(widget.videoCtrl),
                      ),
                    ),
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: FadeInAnim(
                  state: showControler,
                  child: Container(
                    height: 300,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 5),
                        IconBtn(
                          onTap: () {
                            if (isPlaying) {
                              widget.videoCtrl.pause();
                            } else {
                              setState(() {
                                showControler = false;
                                widget.videoCtrl.play();
                              });
                            }
                          },
                          child: IconAnimated(
                            icon: AnimatedIcons.play_pause,
                            state: isPlaying,
                            color: AppColors.white,
                            size: 26,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: Slider(
                              value: position,
                              min: 0,
                              max: duration,
                              onChanged: (value) {
                                widget.videoCtrl.seekTo(
                                    Duration(milliseconds: value.toInt()));
                              },
                              inactiveColor: AppColors.grey200,
                              thumbColor: AppColors.white,
                              overlayColor: MaterialStatePropertyAll(
                                AppColors.white.withOpacity(0.1),
                              ),
                            ),
                          ),
                        ),
                        IconBtn(
                          onTap: () => SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp])
                              .then((value) => Navigator.pop(context)),
                          child: const Icon(
                            Icons.fullscreen_exit_rounded,
                            color: AppColors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconBtn(
                          onTap: () => volume == 0
                              ? widget.videoCtrl.setVolume(1)
                              : widget.videoCtrl.setVolume(0),
                          child: Icon(
                            volume == 0
                                ? Icons.volume_off_rounded
                                : Icons.volume_up_rounded,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
