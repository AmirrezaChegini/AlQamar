import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: SvgPicture.asset(
          AppIcons.logo,
          colorFilter: const ColorFilter.mode(AppColors.red, BlendMode.srcIn),
        ),
      ),
      actions: [
        Container(
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.only(bottom: 10),
          child: const Text(
            'البت المباشر',
            style: TextStyle(
              color: AppColors.red,
              fontSize: 10,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Image.asset(
          AppIcons.live,
          height: 30,
          width: 30,
          color: AppColors.red,
        ),
        const SizedBox(width: 4),
        Image.asset(
          AppIcons.menu,
          height: 30,
          width: 30,
          color: AppColors.red,
        ),
        const SizedBox(width: 10),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(5),
        child: Divider(
          color: AppColors.red,
          thickness: 2,
          indent: 10,
          endIndent: 10,
        ),
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
