import 'package:al_qamar/utils/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalizeCubit extends Cubit<String> {
  LocalizeCubit() : super('system');

  void getLang() async {
    String lng = await Storage.getString(key: 'lang');
    emit(lng);
  }
}
