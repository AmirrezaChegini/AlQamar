import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/live/live_page.dart';
import 'package:al_qamar/widgets/anim/page_route.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/icon_btn_appbar.dart';
import 'package:flutter/material.dart';

class AppbarLeading extends StatelessWidget {
  const AppbarLeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 5),
        Transform.flip(
          flipX: true,
          child: IconBtnAppbar(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: const AppIcon(
              icon: AppIcons.menu,
              color: AppColors.red,
              matchDirection: true,
            ),
          ),
        ),
        const SizedBox(width: 8),
        IconBtnAppbar(
          onTap: () => Navigator.push(
            context,
            pageRoute(child: const LivePage()),
          ),
          child: const AppIcon(
            icon: AppIcons.program,
            color: AppColors.red,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'liveBroadcast'.localize(context),
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
