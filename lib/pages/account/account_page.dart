import 'dart:async';

import 'package:al_qamar/pages/account/auth_page.dart';
import 'package:al_qamar/pages/account/bookmark_page.dart';
import 'package:al_qamar/utils/anim/slide_up.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Timer time;
  bool state = true;

  @override
  void initState() {
    super.initState();
    time = Timer.periodic(const Duration(seconds: 3), (timer) {});
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      fit: StackFit.expand,
      children: [
        BookmarkPage(),
        SlideUpAnim(
          state: false,
          child: AuthPage(),
        ),
      ],
    );
  }
}
