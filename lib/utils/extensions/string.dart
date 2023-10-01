extension StringExt on String {
  String getPureTime() {
    String time = this;
    return time.substring(0, time.indexOf(' '));
  }
}
