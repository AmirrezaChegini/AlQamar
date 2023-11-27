import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/fullscreen/video_fullscreen_page.dart';
import 'package:al_qamar/widgets/anim/animated_icon.dart';
import 'package:al_qamar/widgets/anim/fade_in.dart';
import 'package:al_qamar/widgets/anim/fade_page_trans.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:video_player/video_player.dart';

class VideoArticlePlayer extends StatefulWidget {
  const VideoArticlePlayer({
    super.key,
    required this.video,
  });
  final List<dynamic> video;
  @override
  State<VideoArticlePlayer> createState() => _VideoArticlePlayerState();
}

class _VideoArticlePlayerState extends State<VideoArticlePlayer>
    with AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoCtrl;
  final PageController _pageCtrl = PageController();
  bool isPlaying = false;
  double volume = 0;
  double duration = 1;
  double position = 0;
  bool showControler = true;

  void initial(int index) {
    _videoCtrl = VideoPlayerController.networkUrl(
      Uri.parse(widget.video[index]),
    )
      ..initialize().then((value) => setState(() {}))
      ..addListener(() {
        setState(() {
          isPlaying = _videoCtrl.value.isPlaying;
          volume = _videoCtrl.value.volume;
          duration = _videoCtrl.value.duration.inMilliseconds.toDouble();
          position = _videoCtrl.value.position.inMilliseconds.toDouble();
          if (position == duration - 1) {
            _videoCtrl.pause();
          }
          if (_videoCtrl.value.isCompleted) {
            showControler = true;
          }
          if (_videoCtrl.value.isPlaying && showControler) {
            Future.delayed(const Duration(seconds: 2), () {
              showControler = false;
            });
          }
        });
      });
  }

  @override
  void initState() {
    super.initState();
    initial(0);
  }

  @override
  void dispose() {
    _videoCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.video.isNotEmpty) {
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.video.length,
            controller: _pageCtrl,
            onPageChanged: (index) {
              initial(index);
            },
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.all(10),
              child: GestureDetector(
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
                            maxWidth: _videoCtrl.value.size.width,
                            minWidth: _videoCtrl.value.size.width,
                            maxHeight: _videoCtrl.value.size.height,
                            minHeight: _videoCtrl.value.size.height,
                          ),
                          child: AspectRatio(
                            aspectRatio: _videoCtrl.value.aspectRatio,
                            child: GestureDetector(
                              onTap: () {},
                              child: VideoPlayer(_videoCtrl),
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
                                onTap: () => isPlaying
                                    ? _videoCtrl.pause()
                                    : _videoCtrl.play(),
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
                                      _videoCtrl.seekTo(Duration(
                                          milliseconds: value.toInt()));
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
                                onTap: () => Navigator.push(
                                  context,
                                  pageRoute(
                                    child: VideoFullscrreenPage(
                                        videoCtrl: _videoCtrl),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.fullscreen_rounded,
                                  color: AppColors.white,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 5),
                              IconBtn(
                                onTap: () => volume == 0
                                    ? _videoCtrl.setVolume(1)
                                    : _videoCtrl.setVolume(0),
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
          ),
          Positioned(
            bottom: 20,
            child: SmoothPageIndicator(
              controller: _pageCtrl,
              count: widget.video.isNotEmpty ? widget.video.length : 1,
              effect: const JumpingDotEffect(
                dotColor: AppColors.grey,
                activeDotColor: AppColors.white,
                dotHeight: 6,
                dotWidth: 6,
                spacing: 6,
              ),
            ),
          ),
        ],
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
