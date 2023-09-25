import 'package:flutter_bloc/flutter_bloc.dart';

class BottomnavCubit extends Cubit<int> {
  BottomnavCubit() : super(4);

  int index = 4;

  void saveIndex(int index) {
    this.index = index;
  }
}
