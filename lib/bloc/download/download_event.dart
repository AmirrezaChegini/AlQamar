//audio event
sealed class DownloadAudioEvent {}

class StartDownloadAudioEvent extends DownloadAudioEvent {
  final String url;
  final String fileName;
  StartDownloadAudioEvent(this.url, this.fileName);
}

class CheckDownloadedAudioEvent extends DownloadAudioEvent {
  final String fileName;
  CheckDownloadedAudioEvent(this.fileName);
}

//pdf event
sealed class DownloadPdfEvent {}

class StartDownloadPdfEvent extends DownloadPdfEvent {
  final String url;
  final String fileName;
  StartDownloadPdfEvent(this.url, this.fileName);
}

class CheckDownloadedPdfEvent extends DownloadPdfEvent {
  final String fileName;
  CheckDownloadedPdfEvent(this.fileName);
}
