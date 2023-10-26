import 'dart:async';

import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/anim/animated_icon.dart';
import 'package:al_qamar/utils/extensions/duration.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioArticlePlayer extends StatefulWidget {
  const AudioArticlePlayer({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  State<AudioArticlePlayer> createState() => _AudioArticlePlayerState();
}

class _AudioArticlePlayerState extends State<AudioArticlePlayer> {
  final AudioPlayer _audioPlayer = locator.get();

  Future<void> initial() async {
    List<AudioSource> audioSource = [];
    if (widget.article.audios != null) {
      for (int i = 0; i < widget.article.audios!.length; i++) {
        audioSource.add(
          AudioSource.uri(
            Uri.parse(widget.article.audios?[i]),
            tag: MediaItem(
              id: '1',
              title: 'Audio ${i + 1}',
              artUri: Uri.parse(widget.article.images?[0]),
            ),
          ),
        );
      }
    }
    final ConcatenatingAudioSource playList =
        ConcatenatingAudioSource(children: audioSource);
    _audioPlayer.setAudioSource(
      playList,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20).copyWith(),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CacheImage(
                      imageUrl: widget.article.images?[0] ?? '',
                      height: 100,
                      width: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _audioPlayer.currentIndex != null
                            ? '${'audio'.localize(context)} ${_audioPlayer.currentIndex! + 1}'
                            : 'audio'.localize(context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          const AppIcon(
                            icon: AppIcons.calender,
                            width: 10,
                            height: 10,
                            color: AppColors.black,
                          ),
                          Text(
                            ' ${widget.article.updateAt}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const AppIcon(
                            icon: AppIcons.pen,
                            width: 10,
                            height: 10,
                            color: AppColors.black,
                          ),
                          Text(
                            ' ${widget.article.writer}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 12,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: StreamBuilder(
                  stream: _audioPlayer.durationStream,
                  initialData: Duration.zero,
                  builder: (context, durationSnapshot) => StreamBuilder(
                    stream: _audioPlayer.positionStream,
                    builder: (context, positionSnapshot) => StreamBuilder(
                      stream: _audioPlayer.bufferedPositionStream,
                      builder: (context, bufferedSnapshot) => Slider(
                        secondaryActiveColor: AppColors.grey600,
                        inactiveColor: AppColors.grey200,
                        activeColor: AppColors.blue,
                        overlayColor: MaterialStatePropertyAll(
                          AppColors.blue.withOpacity(0.1),
                        ),
                        min: 0,
                        max: durationSnapshot.data?.inMilliseconds.toDouble() ??
                            1000000,
                        value:
                            positionSnapshot.data?.inMilliseconds.toDouble() ??
                                0,
                        secondaryTrackValue:
                            bufferedSnapshot.data?.inMilliseconds.toDouble(),
                        onChanged: (value) => _audioPlayer
                            .seek(Duration(milliseconds: value.toInt())),
                        onChangeEnd: (value) => _audioPlayer
                            .seek(Duration(milliseconds: value.toInt())),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: _audioPlayer.durationStream,
                    initialData: Duration.zero,
                    builder: (context, snapshot) => Text(
                      snapshot.data.format(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  StreamBuilder(
                    stream: _audioPlayer.positionStream,
                    initialData: Duration.zero,
                    builder: (context, snapshot) => Text(
                      snapshot.data.format(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 5, bottom: 10),
              child: Row(
                children: [
                  IconBtn(
                    onTap: () {
                      _audioPlayer.speed == 1.0
                          ? _audioPlayer.setSpeed(1.25)
                          : _audioPlayer.speed == 1.25
                              ? _audioPlayer.setSpeed(1.5)
                              : _audioPlayer.speed == 1.5
                                  ? _audioPlayer.setSpeed(1.75)
                                  : _audioPlayer.speed == 1.75
                                      ? _audioPlayer.setSpeed(2.0)
                                      : _audioPlayer.setSpeed(1.0);
                    },
                    padding: 5,
                    child: StreamBuilder(
                      stream: _audioPlayer.speedStream,
                      initialData: 1.0,
                      builder: (context, snapshot) => Text(
                        '${snapshot.data} X',
                        textDirection: TextDirection.ltr,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconBtn(
                    onTap: () => _audioPlayer.seekToNext(),
                    child: const Icon(
                      Icons.skip_next_rounded,
                      color: AppColors.blue,
                      size: 40,
                    ),
                  ),
                  IconBtn(
                    onTap: () => _audioPlayer.playing
                        ? _audioPlayer.pause()
                        : _audioPlayer.play(),
                    child: StreamBuilder(
                      stream: _audioPlayer.playingStream,
                      initialData: false,
                      builder: (context, snapshot) => IconAnimated(
                        icon: AnimatedIcons.play_pause,
                        state: snapshot.data!,
                        color: AppColors.blue,
                        size: 35,
                      ),
                    ),
                  ),
                  IconBtn(
                    onTap: () => _audioPlayer.seekToPrevious(),
                    child: const Icon(
                      Icons.skip_previous_rounded,
                      color: AppColors.blue,
                      size: 40,
                    ),
                  ),
                  const Spacer(),
                  IconBtn(
                    onTap: () => _audioPlayer.seek(Duration.zero),
                    child: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
