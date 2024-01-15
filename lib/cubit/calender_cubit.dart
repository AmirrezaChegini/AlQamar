import 'package:flutter_bloc/flutter_bloc.dart';

class CalenderCubit extends Cubit<DateTime> {
  CalenderCubit() : super(DateTime.now());

  void changeDatetime(DateTime dateTime) {
    emit(dateTime);
  }
}
