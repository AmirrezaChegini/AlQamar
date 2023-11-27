import 'package:al_qamar/bloc/azan/azan_event.dart';
import 'package:al_qamar/bloc/azan/azan_state.dart';
import 'package:al_qamar/data/repositories/azan_repository.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AzanBloc extends Bloc<AzanEvent, AzanState> {
  final IAzanRepository _repository;

  AzanBloc(this._repository) : super(InitAzanState()) {
    on<GetAzanTimeEvent>((event, emit) async {
      List<AzanTime> azanTimeList = [];
      String errorMessage = '';

      var londonEither = await _repository.getAzanTime(
        city: 'London',
        country: 'United Kingdom',
        method: 2,
        midnightMode: 1,
        tune: '1,1,1,1,1,1,1,-85',
      );

      var baghdadEither = await _repository.getAzanTime(
        city: 'Baghdad',
        country: 'Iraq',
        method: 3,
        midnightMode: 1,
        tune: '1,-2,-3,0,0,0,0,-63',
      );

      baghdadEither.fold((l) {
        errorMessage = l;
      }, (r) {
        azanTimeList.add(r);
      });

      londonEither.fold((l) {
        errorMessage = l;
      }, (r) {
        azanTimeList.add(r);
      });

      if (azanTimeList.isNotEmpty) {
        emit(CompletedAzanState(azanTimeList));
      } else {
        emit(FailedAzanState(errorMessage));
      }
    });
  }
}
