sealed class DownloadState {}

class InitDownloadState extends DownloadState {}

class DownloadingState extends DownloadState {
  final double progress;
  DownloadingState(this.progress);
}

class CompleteDownloadState extends DownloadState {}

class FailDownloadState extends DownloadState {}
