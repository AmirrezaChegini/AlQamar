import 'package:al_qamar/models/calender.dart';

abstract class CalenderState {}

class InitCalenderState extends CalenderState {}

class LoadingCalenderState extends CalenderState {}

class EmptyCalenderState extends CalenderState {
  final String message;
  EmptyCalenderState(this.message);
}

class CompleteCalenderState extends CalenderState {
  final List<Calender> calenderList;

  CompleteCalenderState(this.calenderList);
}

class FailCalenderState extends CalenderState {
  final String errorMessage;
  FailCalenderState(this.errorMessage);
}
