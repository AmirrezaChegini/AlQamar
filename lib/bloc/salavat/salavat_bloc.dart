import 'package:al_qamar/bloc/salavat/salavat_event.dart';
import 'package:al_qamar/bloc/salavat/salavat_state.dart';
import 'package:al_qamar/data/repositories/salavat_repository.dart';
import 'package:al_qamar/models/salavat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalavatBloc extends Bloc<SalavatEvent, SalavatState> {
  final ISalavatRepository _repository;

  SalavatBloc(this._repository) : super(InitSalavatState()) {
    on<GetAllSalavatEvent>((event, emit) {
      List<Salavat> salavatList = _repository.getAllSalavats();
      emit(CompleteSalavatState(salavatList));
    });

    on<AddSalavatEvent>((event, emit) async {
      await _repository.addSalavat(salavat: event.salavat);
      List<Salavat> salavatList = _repository.getAllSalavats();
      emit(CompleteSalavatState(salavatList));
    });
  }
}
