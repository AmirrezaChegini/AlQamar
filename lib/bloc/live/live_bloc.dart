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

      ApiModel<List<Live>, String> videoEither = await _repository.getVideo();
      ApiModel<List<Live>, String> audioEither = await _repository.getAudio();

      videoEither.fold(
        (data) => videoList = data,
        (error) => errorMessage = error,
      );

      audioEither.fold(
        (data) => audioList = data,
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
