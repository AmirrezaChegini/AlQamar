extension DurationExt on Duration? {
  String format() {
    Duration? duration = this;

    int hours = duration?.inHours ?? 0;
    int minutes = duration?.inMinutes.remainder(60) ?? 0;
    int seconds = duration?.inSeconds.remainder(60) ?? 0;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }
}
