import 'package:flutter_bloc/flutter_bloc.dart';

class AudioCubit extends Cubit<int> {
  AudioCubit() : super(0);

  void chnageIndex(int index) {
    emit(index);
  }
}
