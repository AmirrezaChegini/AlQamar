import 'package:al_qamar/bloc/download/download_bloc.dart';
import 'package:al_qamar/bloc/download/download_event.dart';
import 'package:al_qamar/bloc/download/download_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/audio_cubit.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/permission_handler.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
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
  void initState() {
    super.initState();
    BlocProvider.of<DownloadAudioBloc>(context)
        .add(CheckDownloadedAudioEvent(widget.audio.getFilename()));
  }

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
        trailing: SizedBox(
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<DownloadAudioBloc, DownloadAudioState>(
                builder: (context, innerState) {
                  if (innerState is CompleteDownloadAudioState) {
                    return AppIcon(
                      icon: AppIcons.downloaded,
                      width: 25,
                      height: 25,
                      color: state == widget.index
                          ? AppColors.white
                          : AppColors.black,
                    );
                  }
                  if (innerState is DownloadingAudioState) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: AppIcon(
                        icon: AppIcons.downloading,
                        width: 25,
                        height: 25,
                        color: state == widget.index
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    );
                  }
                  return IconBtn(
                    onTap: () async {
                      await storagePermission().then((value) {
                        if (value) {
                          BlocProvider.of<DownloadAudioBloc>(context).add(
                            StartDownloadAudioEvent(
                              widget.audio,
                              widget.audio.getFilename(),
                            ),
                          );
                        }
                      });
                    },
                    child: AppIcon(
                      icon: AppIcons.downloading,
                      width: 25,
                      height: 25,
                      color: state == widget.index
                          ? AppColors.white
                          : AppColors.black,
                    ),
                  );
                },
              ),
              BlocBuilder<DownloadAudioBloc, DownloadAudioState>(
                builder: (context, innerState) {
                  if (innerState is DownloadingAudioState) {
                    return LinearProgressIndicator(
                      value: innerState.progress,
                      borderRadius: BorderRadius.circular(20),
                      backgroundColor: AppColors.grey600,
                      color: state == widget.index
                          ? AppColors.white
                          : AppColors.black,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
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
                '${'audio'.localize(context)} ${widget.index + 1}'.toArabic(),
                style: const TextStyle(
                  fontSize: Fontsize.big,
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
