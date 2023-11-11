import 'package:al_qamar/bloc/program/program_event.dart';
import 'package:al_qamar/bloc/program/program_state.dart';
import 'package:al_qamar/data/repositories/live_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final ILiveRepository _repository;

  ProgramBloc(this._repository) : super(InitProgramState()) {
    on<GetAllProgramsEvent>((event, emit) async {
      emit(LoadingProgramState());
      var either = await _repository.getAllPrograms();

      either.fold((l) {
        emit(FailProgramState(l));
      }, (r) {
        print(r.length);
        print(r[0].programList.length);
        emit(CompleteProgramState(r));
      });
    });
  }
}
