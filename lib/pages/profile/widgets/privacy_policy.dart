import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/pages/privacy/privacy_page.dart';
import 'package:al_qamar/widgets/anim/page_route.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.grey200,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          pageRoute(child: const PrivacyPage()),
        ),
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 80,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              'privacyPolicy'.localize(context),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: Fontsize.big),
            ),
          ),
        ),
      ),
    );
  }
}
