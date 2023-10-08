import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/pages/profile/profile_page.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AppBar(
        backgroundColor: AppColors.grey200,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.all(5),
          child: SvgIcon(
            icon: AppIcons.logo,
            height: 25,
            width: 25,
            color: AppColors.red,
          ),
        ),
        actions: [
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              'البت المباشر',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontSize: 12),
            ),
          ),
          const SizedBox(width: 4),
          const SvgIcon(
            icon: AppIcons.live,
            height: 25,
            width: 25,
            color: AppColors.red,
          ),
          const SizedBox(width: 15),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: AppColors.transparent,
                builder: (context) => DraggableScrollableSheet(
                  minChildSize: 0.8,
                  maxChildSize: 1,
                  initialChildSize: 1,
                  builder: (context, scrollController) => ProfilePage(
                    scrollController: scrollController,
                  ),
                ),
              );
            },
            child: const SvgIcon(
              icon: AppIcons.menu,
              height: 15,
              width: 15,
              color: AppColors.red,
            ),
          ),
          const SizedBox(width: 10),
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
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
