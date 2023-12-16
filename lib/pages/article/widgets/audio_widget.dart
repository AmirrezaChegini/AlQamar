import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/cubit/audio_cubit.dart';
import 'package:al_qamar/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioWidget extends StatefulWidget {
  const AudioWidget({
    super.key,
    required this.index,
    required this.audio,
    required this.image,
  });

  final int index;
  final String audio;
  final String image;

  @override
  State<AudioWidget> createState() => _AudioWidgetState();
}

class _AudioWidgetState extends State<AudioWidget> {
  final AudioPlayer _audioPlayer = locator.get();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, int>(
      builder: (context, state) => ListTile(
        onTap: () {
          int index = BlocProvider.of<AudioCubit>(context).state;

          if (index != widget.index) {
            _audioPlayer.setAudioSource(
              AudioSource.uri(
                Uri.parse(widget.audio),
                tag: MediaItem(
                  id: '1',
                  title: 'Audio ${widget.index + 1}',
                  artUri: Uri.parse(widget.image),
                ),
              ),
            );
            BlocProvider.of<AudioCubit>(context).changeIndex(widget.index);
          }
        },
        selected: state == widget.index,
        tileColor: AppColors.white,
        selectedTileColor: AppColors.red,
        textColor: AppColors.black,
        selectedColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        leading: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${'audio'.localize(context)} ${widget.index + 1}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
