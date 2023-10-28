import 'package:flutter_bloc/flutter_bloc.dart';

class ArticleCubit extends Cubit<int> {
  ArticleCubit() : super(0);

  void changeIndex(int index) {
    emit(index);
  }
}
