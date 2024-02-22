import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({
    super.key,
    required this.images,
    required this.index,
  });

  final List<dynamic> images;
  final int index;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  late final PageController _controller;
  bool _isSCroll = true;
  final TransformationController _transformCtrl = TransformationController();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    _controller.dispose();
    _transformCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: PageView.builder(
        controller: _controller,
        physics: _isSCroll
            ? const PageScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: widget.images.length,
        itemBuilder: (context, index) => InteractiveViewer(
          transformationController: _transformCtrl,
          onInteractionUpdate: (details) {
            setState(() {
              _isSCroll = _transformCtrl.value.getMaxScaleOnAxis() <= 1.0;
            });
          },
          child: CacheImage(
            imageUrl: widget.images[index],
            height: MediaQuery.sizeOf(context).height,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
