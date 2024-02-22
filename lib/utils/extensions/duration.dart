extension DurationExt on Duration? {
  String format() {
    int hours = this?.inHours ?? 0;
    int minutes = this?.inMinutes.remainder(60) ?? 0;
    int seconds = this?.inSeconds.remainder(60) ?? 0;

    String formattedHours = hours.toString().padLeft(2, '0');
    String formattedMinutes = minutes.toString().padLeft(2, '0');
    String formattedSeconds = seconds.toString().padLeft(2, '0');

    return '$formattedHours:$formattedMinutes:$formattedSeconds';
  }
}
