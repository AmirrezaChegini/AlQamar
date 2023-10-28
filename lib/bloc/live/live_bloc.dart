import 'package:al_qamar/bloc/live/live_event.dart';
import 'package:al_qamar/bloc/live/live_state.dart';
import 'package:al_qamar/data/repositories/live_repository.dart';
import 'package:al_qamar/models/live.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final ILiveRepository _repository;

  LiveBloc(this._repository) : super(InitLiveState()) {
    on<GetLiveEvent>((event, emit) async {
      emit(LoadingLiveState());
      List<Live> audioList = [];
      List<Live> videoList = [];
      String errorMessage = '';

      var videoEither = await _repository.getVideo();
      var audioEither = await _repository.getAudio();

      videoEither.fold((l) {
        errorMessage = l;
      }, (r) {
        videoList = r;
      });

      audioEither.fold((l) {
        errorMessage = l;
      }, (r) {
        audioList = r;
      });

      if (videoList.isNotEmpty || audioList.isNotEmpty) {
        emit(CompleteLiveState(audioList, videoList));
      } else {
        emit(FailLiveState(errorMessage));
      }
    });
  }
}
