import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class TimerCubit extends Cubit<int> {
  TimerCubit() : super(90);

  int otpTimer = 90;
  Timer? timer;

  void cancel() {
    otpTimer = 90;
    timer?.cancel();
    timer = null;
  }

  void startTimer() {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      --otpTimer;

      emit(otpTimer);

      if (otpTimer == 0) {
        timer.cancel();
      }
    });
  }
}
