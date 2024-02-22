import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Cellbuilder extends StatelessWidget {
  const Cellbuilder({
    super.key,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.date,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final HijriDateRangePickerCellDetails date;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            '${date.date.day}'.toArabic(),
            style: TextStyle(
              fontSize: Fontsize.big,
              color: foregroundColor,
            ),
          ),
          Positioned.directional(
            textDirection: CheckDirect.isRTL(context)
                ? TextDirection.rtl
                : TextDirection.ltr,
            bottom: 2,
            end: 8,
            child: Text(
              '${date.date.toDateTime().day}',
              style: TextStyle(
                fontSize: Fontsize.medium,
                color: foregroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
