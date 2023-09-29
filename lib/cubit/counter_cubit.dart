import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  int index = 0;

  void setCounter(int i) {
    index = i;
    emit(index);
  }

  void increaseCounter() {
    ++index;
    emit(index);
  }

  void resetCounter() {
    index = 0;
    emit(index);
  }
}
