import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppbar(
        title: 'live'.localize(context),
        showLeading: false,
      ),
    );
  }
}
