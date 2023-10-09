import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/pages/auth/auth_page.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({
    super.key,
  });

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  String? username;

  Future<void> authenticate() async {
    username = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      builder: (context) => DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, scrollController) => const AuthPage(),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80,
            foregroundDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.3,
                image: AssetImage(AppImages.profileBackground),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  AppColors.white,
                  AppColors.blue,
                ],
                tileMode: TileMode.decal,
                begin: AlignmentDirectional.centerStart,
                end: AlignmentDirectional.centerEnd,
              ),
            ),
          ),
          Positioned.fill(
            top: 40,
            right: 20,
            child: Row(
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 80,
                    height: 80,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                    ),
                    child: const SvgIcon(
                      icon: AppIcons.profile,
                      color: AppColors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username == null ? 'حساب تعریفی' : 'مرحباً',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: authenticate,
                      child: Text.rich(
                        TextSpan(
                          text: username == null
                              ? 'إنشاء ملف تعریف  |  '
                              : '$username  |  ',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontSize: 14),
                          children: [
                            TextSpan(
                              text: username == null
                                  ? 'تسجیل الدخول'
                                  : 'تعدیل ملف شخصی',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 12),
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
