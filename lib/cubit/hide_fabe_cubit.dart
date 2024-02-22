import 'package:flutter_bloc/flutter_bloc.dart';

class HideFabeCubit extends Cubit<bool> {
  HideFabeCubit() : super(false);

  void changeVisibility(bool visible) {
    emit(visible);
  }
}
