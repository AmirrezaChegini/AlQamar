import 'package:al_qamar/bloc/live/live_event.dart';
import 'package:al_qamar/bloc/live/live_state.dart';
import 'package:al_qamar/data/repositories/live_repository.dart';
import 'package:al_qamar/models/live.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final ILiveRepository _repository;

  LiveBloc(this._repository) : super(InitLiveState()) {
    on<GetLiveEvent>((event, emit) async {
      emit(LoadingLiveState());
      List<Live> audioList = [];
      List<Live> videoList = [];
      String errorMessage = '';

      ApiModel<List<Live>, String> either = await _repository.getLive();

      either.fold(
        (data) {
          audioList = data.where((e) => e.type == LiveType.audio).toList();
          videoList = data.where((e) => e.type == LiveType.video).toList();
        },
        (error) => errorMessage = error,
      );

      if (videoList.isNotEmpty || audioList.isNotEmpty) {
        emit(CompleteLiveState(audioList, videoList));
      } else {
        emit(FailLiveState(errorMessage));
      }
    });
  }
}
