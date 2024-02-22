import 'dart:async';

import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/audio_cubit.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/utils/extensions/duration.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/widgets/anim/animated_icon.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioArticlePlayer extends StatefulWidget {
  const AudioArticlePlayer({
    super.key,
    required this.audios,
    required this.image,
    required this.date,
    required this.writer,
  });

  final List<dynamic> audios;
  final String image;
  final String date;
  final String writer;

  @override
  State<AudioArticlePlayer> createState() => _AudioArticlePlayerState();
}

class _AudioArticlePlayerState extends State<AudioArticlePlayer>
    with AutomaticKeepAliveClientMixin {
  final AudioPlayer _audioPlayer = locator.get();
  Timer? timer;
  List<AudioSource> audioSource = [];

  Future<void> initial() async {
    BlocProvider.of<AudioCubit>(context).changeIndex(0);
    if (widget.audios.isNotEmpty) {
      for (int i = 0; i < widget.audios.length; i++) {
        audioSource.add(
          AudioSource.uri(
            Uri.parse(widget.audios[i]),
            tag: MediaItem(
              id: '1',
              title: 'Audio ${i + 1}',
              artUri: Uri.parse(widget.image),
            ),
          ),
        );
      }
      _audioPlayer.setAudioSource(audioSource[0]);
    } else {
      _audioPlayer.stop();
      _audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(''),
          tag: MediaItem(
            id: '1',
            title: 'Audio',
            artUri: Uri.parse(widget.image),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initial();
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_audioPlayer.position.inSeconds == _audioPlayer.duration?.inSeconds) {
        BlocProvider.of<AudioCubit>(context).i < audioSource.length - 1
            ? _audioPlayer.setAudioSource(
                audioSource[BlocProvider.of<AudioCubit>(context).i + 1])
            : _audioPlayer.stop();

        if (BlocProvider.of<AudioCubit>(context).i < audioSource.length - 1) {
          BlocProvider.of<AudioCubit>(context).i++;
          _audioPlayer.setAudioSource(
              audioSource[BlocProvider.of<AudioCubit>(context).i]);
          BlocProvider.of<AudioCubit>(context)
              .changeIndex(BlocProvider.of<AudioCubit>(context).i);
        } else {
          _audioPlayer.stop();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.audios.isNotEmpty) {
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
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CacheImage(
                        imageUrl: widget.image,
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
                          'audio'.localize(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: Fontsize.big),
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
                              ' ${widget.date}'.toArabic(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: Fontsize.large),
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
                              ' ${widget.writer}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: Fontsize.large),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 10,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: StreamBuilder(
                    stream: _audioPlayer.durationStream,
                    initialData: Duration.zero,
                    builder: (context, durationSnapshot) => StreamBuilder(
                      stream: _audioPlayer.positionStream,
                      builder: (context, positionSnapshot) => StreamBuilder(
                        stream: _audioPlayer.bufferedPositionStream,
                        builder: (context, bufferSnapshot) => Slider(
                          inactiveColor: AppColors.grey200,
                          min: 0,
                          max: durationSnapshot.data?.inMilliseconds
                                  .roundToDouble() ??
                              1000000,
                          value: positionSnapshot.data?.inMilliseconds
                                  .roundToDouble() ??
                              0,
                          secondaryTrackValue: bufferSnapshot
                                  .data?.inMilliseconds
                                  .roundToDouble() ??
                              0,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            .copyWith(fontSize: Fontsize.large),
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
                            .copyWith(fontSize: Fontsize.large),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: IconBtn(
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
                        child: StreamBuilder(
                          stream: _audioPlayer.speedStream,
                          initialData: 1.0,
                          builder: (context, snapshot) => Text(
                            '${snapshot.data} X',
                            textDirection: TextDirection.ltr,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: Fontsize.large),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconBtn(
                      onTap: () {
                        if (BlocProvider.of<AudioCubit>(context).i <
                            audioSource.length - 1) {
                          BlocProvider.of<AudioCubit>(context).i++;
                          _audioPlayer.setAudioSource(audioSource[
                              BlocProvider.of<AudioCubit>(context).i]);
                          BlocProvider.of<AudioCubit>(context).changeIndex(
                              BlocProvider.of<AudioCubit>(context).i);
                        } else {
                          _audioPlayer.stop();
                        }
                      },
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
                      onTap: () {
                        BlocProvider.of<AudioCubit>(context).i == 0
                            ? _audioPlayer.stop()
                            : _audioPlayer.setAudioSource(audioSource[
                                BlocProvider.of<AudioCubit>(context).i - 1]);

                        if (BlocProvider.of<AudioCubit>(context).i == 0) {
                          _audioPlayer.stop();
                        } else {
                          BlocProvider.of<AudioCubit>(context).i--;
                          _audioPlayer.setAudioSource(audioSource[
                              BlocProvider.of<AudioCubit>(context).i]);
                          BlocProvider.of<AudioCubit>(context).changeIndex(
                              BlocProvider.of<AudioCubit>(context).i);
                        }
                      },
                      child: const Icon(
                        Icons.skip_previous_rounded,
                        color: AppColors.blue,
                        size: 40,
                      ),
                    ),
                    const Spacer(),
                    IconBtn(
                      onTap: () => _audioPlayer.seek(Duration.zero),
                      padding: 10,
                      child: const Icon(
                        Icons.refresh_rounded,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(70),
          child: AppIcon(
            icon: AppIcons.audio,
            color: AppColors.grey600,
          ),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
