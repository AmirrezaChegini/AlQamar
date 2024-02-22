import 'package:flutter_bloc/flutter_bloc.dart';

class LiveCubit extends Cubit<String> {
  LiveCubit() : super('');

  void changeUrl(String url) {
    emit(url);
  }
}
