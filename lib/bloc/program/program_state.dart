import 'package:al_qamar/models/program_time.dart';

sealed class ProgramState {}

class InitProgramState extends ProgramState {}

class LoadingProgramState extends ProgramState {}

class CompleteProgramState extends ProgramState {
  List<ProgramTime> audioProgramList;
  List<ProgramTime> videoProgramList;

  CompleteProgramState(this.audioProgramList, this.videoProgramList);
}

class FailedProgramState extends ProgramState {
  final String errorMessage;
  FailedProgramState(this.errorMessage);
}
