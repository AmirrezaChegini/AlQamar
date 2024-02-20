import 'package:al_qamar/bloc/azan/azan_event.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/data/repositories/azan_repository.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzanBloc extends Bloc<AzanEvent, AzanState> {
  final IAzanRepository _repository;

  AzanBloc(this._repository) : super(InitAzanState()) {
    on<GetAzanTimeEvent>((event, emit) async {
      List<AzanTime> azanTimeList = [];
      String errorMessage = '';

      ApiModel<AzanTime, String> londonEither = await _repository.getAzanTime(
        city: 'London',
        country: 'United Kingdom',
        method: 2,
        midnightMode: 1,
        tune: '1,1,1,1,1,1,1,-85',
      );

      ApiModel<AzanTime, String> baghdadEither = await _repository.getAzanTime(
        city: 'Baghdad',
        country: 'Iraq',
        method: 3,
        midnightMode: 1,
        tune: '1,-2,-3,0,0,0,0,-63',
      );

      baghdadEither.fold(
        (data) => azanTimeList.add(data),
        (error) => errorMessage = error,
      );

      londonEither.fold(
        (data) => azanTimeList.add(data),
        (error) => errorMessage = error,
      );

      if (azanTimeList.isNotEmpty) {
        emit(CompletedAzanState(azanTimeList));
      } else {
        emit(FailedAzanState(errorMessage));
      }
    });
  }
}
