import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  Future<String> privacyText() async {
    try {
      return rootBundle.loadString('assets/docs/privacy.txt');
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: 'privacyPolicy'.localize(context),
        appbarLeading: const BackButton(
          color: AppColors.red,
        ),
      ),
      body: ListView(
        children: [
          FutureBuilder<String>(
            future: privacyText(),
            initialData: '',
            builder: (context, snapshot) => Padding(
              padding: const EdgeInsets.all(10),
              child: SelectionArea(
                child: Text(
                  snapshot.data ?? '',
                  textAlign: TextAlign.start,
                  selectionColor: AppColors.red100,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: Fontsize.big, height: 1.2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
