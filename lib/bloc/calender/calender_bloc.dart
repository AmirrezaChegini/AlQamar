import 'package:al_qamar/bloc/calender/calender_event.dart';
import 'package:al_qamar/bloc/calender/calender_state.dart';
import 'package:al_qamar/data/repositories/calender_repositoy.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalenderBloc extends Bloc<CalenderEvent, CalenderState> {
  final ICalenderRepository _repository;
  CalenderBloc(this._repository) : super(InitCalenderState()) {
    on<GetCalenderEvent>((event, emit) async {
      emit(LoadingCalenderState());
      var either = await _repository.getCalender(day: event.day);

      either.fold((l) {
        emit(FailCalenderState(l));
      }, (r) {
        if (r.isEmpty) {
          emit(EmptyCalenderState('Nothing calender to show'));
        } else {
          emit(CompleteCalenderState(r));
        }
      });
    });
  }
}
