import 'package:html/parser.dart';

extension StringExt on String {
  String getPureTime() {
    String time = this;
    return time.substring(0, time.indexOf(' '));
  }

  String htmlToString() {
    String htmlString = this;

    var document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }
}
