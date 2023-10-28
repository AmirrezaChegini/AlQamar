import 'package:flutter_bloc/flutter_bloc.dart';

class PdfCubit extends Cubit<int> {
  PdfCubit() : super(0);

  void chnageIndex(int index) {
    emit(index);
  }
}
