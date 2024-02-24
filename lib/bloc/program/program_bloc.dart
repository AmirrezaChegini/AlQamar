import 'package:al_qamar/bloc/program/program_event.dart';
import 'package:al_qamar/bloc/program/program_state.dart';
import 'package:al_qamar/data/repositories/live_repository.dart';
import 'package:al_qamar/models/live.dart';
import 'package:al_qamar/models/program_time.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:bloc/bloc.dart';

class ProgramBloc extends Bloc<ProgramEvent, ProgramState> {
  final ILiveRepository _repository;

  ProgramBloc(this._repository) : super(InitProgramState()) {
    on<GetProgramEvent>((event, emit) async {
      emit(LoadingProgramState());
      List<ProgramTime> audioProgramList = [];
      List<ProgramTime> videoProgramList = [];
      String errorMessage = '';

      ApiModel<List<ProgramTime>, String> either =
          await _repository.getProgram();

      either.fold(
        (data) {
          audioProgramList =
              data.where((e) => e.live.type == LiveType.audio).toList();
          videoProgramList =
              data.where((e) => e.live.type == LiveType.video).toList();
        },
        (error) => errorMessage = error,
      );

      if (audioProgramList.isNotEmpty || videoProgramList.isNotEmpty) {
        emit(CompleteProgramState(audioProgramList, videoProgramList));
      } else {
        emit(FailedProgramState(errorMessage));
      }
    });
  }
}
