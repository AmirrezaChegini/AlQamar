import 'package:flutter_bloc/flutter_bloc.dart';

class SalavatCubit extends Cubit<int> {
  SalavatCubit() : super(-1);

  void chooseIndex(int index) {
    emit(index);
  }
}
