//audio state
sealed class DownloadAudioState {}

class InitDownloadAudioState extends DownloadAudioState {}

class DownloadingAudioState extends DownloadAudioState {
  final double progress;
  DownloadingAudioState(this.progress);
}

class CompleteDownloadAudioState extends DownloadAudioState {}

class FailDownloadAudioState extends DownloadAudioState {}

//pdf state
sealed class DownloadPdfState {}

class InitDownloadPdfState extends DownloadPdfState {}

class DownloadingPdfState extends DownloadPdfState {
  final double progress;
  DownloadingPdfState(this.progress);
}

class CompleteDownloadPdfState extends DownloadPdfState {}

class FailDownloadPdfState extends DownloadPdfState {}
