import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/utils/rtl_direct.dart';
import 'package:flutter/material.dart';
import 'package:widget_mask/widget_mask.dart';

class MaskImage extends StatefulWidget {
  const MaskImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  State<MaskImage> createState() => _MaskImageState();
}

class _MaskImageState extends State<MaskImage> {
  late final Image _error;
  late final Image _mask;

  @override
  void initState() {
    super.initState();
    try {
      _error = Image.asset(AppImages.error, fit: BoxFit.cover);
      _mask = Image.asset(AppImages.mask);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: CheckDirect.isRTL(context) ? false : true,
      child: WidgetMask(
        childSaveLayer: true,
        blendMode: BlendMode.srcIn,
        mask: Transform.flip(
          flipX: CheckDirect.isRTL(context) ? false : true,
          child: FadeInImage.assetNetwork(
            placeholder: AppImages.transparent,
            image: widget.imageUrl,
            imageErrorBuilder: (context, error, stackTrace) => _error,
            fit: BoxFit.cover,
          ),
        ),
        child: _mask,
      ),
    );
  }
}
