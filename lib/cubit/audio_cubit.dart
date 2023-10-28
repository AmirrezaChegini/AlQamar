import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class AudioCubit extends Cubit<int> {
  final AudioPlayer _audioPlayer;
  AudioCubit(this._audioPlayer) : super(0);
  Timer? timer;

  void changeIndex() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(_audioPlayer.currentIndex ?? 0);
    });
  }
}
