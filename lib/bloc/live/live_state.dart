import 'package:al_qamar/models/live.dart';

sealed class LiveState {}

class InitLiveState extends LiveState {}

class LoadingLiveState extends LiveState {}

class CompleteLiveState extends LiveState {
  final List<Live> audioList;
  final List<Live> videoList;
  CompleteLiveState(this.audioList, this.videoList);
}

class FailLiveState extends LiveState {
  final String errorMessage;
  FailLiveState(this.errorMessage);
}
