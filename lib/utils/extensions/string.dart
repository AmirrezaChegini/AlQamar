import 'package:html/parser.dart';

extension StringExt on String {
  String htmlToString() {
    String htmlString = this;

    var document = parse(htmlString);
    return parse(document.body?.text).documentElement?.text ?? '';
  }

  String getFilename() {
    String url = this;

    return Uri.parse(url).pathSegments.last;
  }
}
