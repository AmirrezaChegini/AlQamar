import 'package:flutter_bloc/flutter_bloc.dart';

class AudioCubit extends Cubit<int> {
  AudioCubit() : super(0);

  int i = 0;

  void changeIndex(int index) {
    i = index;
    emit(i);
  }
}
