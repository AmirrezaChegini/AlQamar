import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/setting/lang_drop_btn.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: 'setting'.localize(context),
        showLeading: false,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            tileColor: AppColors.white,
            title: Text('language'.localize(context)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            trailing: const LangDropBtn(),
          ),
        ),
      ]),
    );
  }
}
