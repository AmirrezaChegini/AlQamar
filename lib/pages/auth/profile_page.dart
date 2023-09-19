import 'dart:async';

import 'package:al_qamar/pages/auth/auth_page.dart';
import 'package:al_qamar/pages/auth/bookmark_page.dart';
import 'package:al_qamar/utils/anim/slide_up.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Timer time;
  bool state = true;

  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        state = !state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const BookmarkPage(),
        SlideUpAnim(
          state: state,
          child: const AuthPage(),
        ),
      ],
    );
  }
}
