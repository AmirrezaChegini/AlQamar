import 'package:al_qamar/bloc/calender/calender_event.dart';
import 'package:al_qamar/bloc/calender/calender_state.dart';
import 'package:al_qamar/data/repositories/calender_repositoy.dart';
import 'package:al_qamar/models/calender.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  final ICalenderRepository _repository;
  CalenderBloc(this._repository) : super(InitCalenderState()) {
    on<GetAllCalenderEvent>((event, emit) async {
      emit(LoadingCalenderState());

      String token = await Storage.getString(key: 'token');

      if (token.isEmpty) {
        emit(FailedCalenderState('unauthenticated'));
      } else {
        ApiModel<List<Calender>, String> either =
            await _repository.getAllCalender(day: event.day);

        either.fold(
          (data) {
            if (data.isEmpty) {
              emit(EmptyCalenderState('nothingCalenderToShow'));
            } else {
              emit(CompleteCalenderState(data));
            }
          },
          (error) => emit(FailedCalenderState(error)),
        );
      }
    });
  }
}
