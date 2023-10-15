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
  late final Image _image;
  late final Image _placeHolder;
  late final Image _mask;

  @override
  void initState() {
    super.initState();

    _image = Image.network(widget.imageUrl);
    _placeHolder = Image.asset(AppImages.transparent);
    _mask = Image.asset(AppImages.mask);
  }

  @override
  void didChangeDependencies() {
    precacheImage(_image.image, context);
    precacheImage(_placeHolder.image, context);
    precacheImage(_mask.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.flip(
      flipX: CheckDirect.isRTL(context) ? false : true,
      child: WidgetMask(
        childSaveLayer: true,
        blendMode: BlendMode.srcIn,
        mask: FadeInImage(
          fit: BoxFit.cover,
          alignment: Alignment.centerLeft,
          image: _image.image,
          placeholder: _placeHolder.image,
        ),
        child: _mask,
      ),
    );
  }
}
