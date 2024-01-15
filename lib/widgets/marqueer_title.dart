import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:marqueer/marqueer.dart';

class MarqueerTitle extends StatelessWidget {
  const MarqueerTitle({
    super.key,
    required this.marqueerController,
    required this.title,
  });

  final MarqueerController marqueerController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Marqueer(
      autoStart: false,
      infinity: false,
      controller: marqueerController,
      direction: CheckDirect.isRTL(context)
          ? MarqueerDirection.rtl
          : MarqueerDirection.ltr,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .displayLarge!
            .copyWith(fontSize: Fontsize.large),
        maxLines: 1,
        overflow: TextOverflow.clip,
      ),
    );
  }
}
