import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/pages/main_wrapper/main_wrapper_page.dart';
import 'package:al_qamar/utils/anim/fade_page_trans.dart';
import 'package:al_qamar/utils/anim/fade_rotate.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> goToMainWrapperPage() async {
    await Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.pushReplacement(
            context, fadePageTran(child: const MainWrapperPage()));
      },
    );
  }

  @override
  void initState() {
    super.initState();

    goToMainWrapperPage();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.splashBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FadeRotateAnim(
            child: AppIcon(
              icon: AppIcons.logo,
              height: 120,
              width: 120,
            ),
          ),
        ),
      ),
    );
  }
}
