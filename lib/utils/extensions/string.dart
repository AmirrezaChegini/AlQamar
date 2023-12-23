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

  String toArabic() {
    const Map<String, String> numbers = {
      '0': '۰',
      '1': '۱',
      '2': '۲',
      '3': '۳',
      '4': '۴',
      '5': '۵',
      '6': '۶',
      '7': '۷',
      '8': '۸',
      '9': '۹',
    };

    return replaceAllMapped(
      RegExp('[0-9]'),
      (match) => numbers[this[match.start]]!,
    );
  }
}
