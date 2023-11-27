import 'package:al_qamar/models/live.dart';

abstract class ProgramState {}

class InitProgramState extends ProgramState {}

class LoadingProgramState extends ProgramState {}

class CompleteProgramState extends ProgramState {
  final List<Live> allProgramList;
  CompleteProgramState(this.allProgramList);
}

class FailProgramState extends ProgramState {
  final String errorMessage;
  FailProgramState(this.errorMessage);
}
