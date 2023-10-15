import 'package:flutter_bloc/flutter_bloc.dart';

class BtnVerifyCubit extends Cubit<bool> {
  BtnVerifyCubit() : super(false);

  void clickable(bool click) {
    emit(click);
  }
}
