import 'package:al_qamar/models/azan_time.dart';

abstract class AzanState {}

class InitAzanState extends AzanState {}

class CompletedAzanState extends AzanState {
  final List<AzanTime> azanTimeList;
  CompletedAzanState(this.azanTimeList);
}

class FailedAzanState extends AzanState {
  final String errorMessage;
  FailedAzanState(this.errorMessage);
}
