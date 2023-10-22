import 'dart:async';

import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/audio_cubit.dart';
import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/utils/anim/animated_icon.dart';
import 'package:al_qamar/utils/extensions/duration.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

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
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _timer;
  Duration? totalDuration;
  Duration? currentPosition;

  Future<void> initial() async {
    if (widget.article.audios != null) {
      int index = BlocProvider.of<AudioCubit>(context).state;
      await _audioPlayer
          .setAudioSource(
              AudioSource.uri(Uri.parse(widget.article.audios?[index])))
          .then((value) => setState(() {
                totalDuration = value;
                currentPosition = _audioPlayer.position;
              }));
    }
  }

  @override
  void initState() {
    super.initState();
    initial();
    _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {
              if (widget.article.audios != null) {
                if (currentPosition?.inSeconds ==
                    totalDuration!.inSeconds - 1) {
                  _audioPlayer.seek(const Duration(microseconds: 0));
                  _audioPlayer.stop();
                }
              }
              currentPosition = _audioPlayer.position;
            }));
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
                    BlocBuilder<AudioCubit, int>(
                      builder: (context, state) => Text(
                        '${'audio'.localize(context)} ${state + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
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
              child: Slider(
                min: 0,
                max: double.parse('${totalDuration?.inMicroseconds ?? 1}'),
                value: double.parse('${currentPosition?.inMicroseconds ?? 0}'),
                inactiveColor: AppColors.grey200,
                activeColor: AppColors.blue,
                overlayColor: MaterialStatePropertyAll(
                  AppColors.blue.withOpacity(0.1),
                ),
                onChanged: (value) => setState(() {
                  currentPosition = Duration(microseconds: value.toInt());
                }),
                onChangeEnd: (value) => setState(() {
                  _audioPlayer.seek(Duration(microseconds: value.toInt()));
                }),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalDuration?.format() ?? '00:00:00',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 12),
                ),
                Text(
                  currentPosition?.format() ?? '00:00:00',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 5, bottom: 10),
            child: Row(
              children: [
                Text(
                  '1.0 X',
                  textDirection: TextDirection.ltr,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: 12),
                ),
                const Spacer(),
                IconBtn(
                  onTap: () {},
                  child: const Icon(
                    Icons.skip_next_rounded,
                    color: AppColors.blue,
                    size: 40,
                  ),
                ),
                IconBtn(
                  onTap: () async => _audioPlayer.playing
                      ? await _audioPlayer.pause()
                      : await _audioPlayer.play(),
                  child: IconAnimated(
                    icon: AnimatedIcons.play_pause,
                    state: _audioPlayer.playing,
                    color: AppColors.blue,
                    size: 35,
                  ),
                ),
                IconBtn(
                  onTap: () {},
                  child: const Icon(
                    Icons.skip_previous_rounded,
                    color: AppColors.blue,
                    size: 40,
                  ),
                ),
                const Spacer(),
                IconBtn(
                  onTap: () => setState(() {
                    _audioPlayer.seek(const Duration(microseconds: 0));
                  }),
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
    );
  }
}
