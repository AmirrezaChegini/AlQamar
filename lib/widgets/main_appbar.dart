import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/icon_btn_appbar.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
    this.showLeading = true,
    this.title = '',
  });

  final bool showLeading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.grey200,
      elevation: 0,
      automaticallyImplyLeading: false,
      leadingWidth: MediaQuery.sizeOf(context).width / 2,
      title: Text(title),
      titleTextStyle:
          Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
      titleSpacing: 10,
      leading: showLeading
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 5),
                Transform.flip(
                  flipX: true,
                  child: IconBtnAppbar(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: const SvgIcon(
                      icon: AppIcons.menu,
                      height: 15,
                      width: 15,
                      color: AppColors.red,
                      matchDirection: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconBtnAppbar(
                  onTap: () {},
                  child: const SvgIcon(
                    icon: AppIcons.live,
                    height: 23,
                    width: 23,
                    color: AppColors.red,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'البت المباشر',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          : null,
      actions: const [
        Padding(
          padding: EdgeInsets.all(3),
          child: SvgIcon(
            icon: AppIcons.logo,
            height: 60,
            width: 60,
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
