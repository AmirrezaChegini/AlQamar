import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    this.title = '',
    this.appbarLeading,
    this.leadingWidth,
  });

  final String title;
  final Widget? appbarLeading;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.grey200,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth,
      title: Text(title),
      titleTextStyle:
          Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 17),
      titleSpacing: 10,
      leading: appbarLeading,
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: AppIcon(
            icon: AppIcons.logo,
            height: 40,
            width: 40,
            color: AppColors.red,
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(5),
        child: Container(
          color: AppColors.red,
          height: 2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
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
