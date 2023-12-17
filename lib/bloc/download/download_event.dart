sealed class DownloadEvent {}

class StartDownloadEvent extends DownloadEvent {
  final String url;
  final String fileName;
  StartDownloadEvent(this.url, this.fileName);
}

class CheckDownloadedEvent extends DownloadEvent {
  final String fileName;
  CheckDownloadedEvent(this.fileName);
}
