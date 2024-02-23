import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/di.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/pages/auth/auth_page.dart';
import 'package:al_qamar/pages/profile/edit_profile_page.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderProfile extends StatefulWidget {
  const HeaderProfile({
    super.key,
  });

  @override
  State<HeaderProfile> createState() => _HeaderProfileState();
}

class _HeaderProfileState extends State<HeaderProfile> {
  UserBloc userBloc = locator.get();

  Future<void> authenticate() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.grey200,
      builder: (context) => DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, scrollController) => const AuthPage(),
      ),
    );
  }

  Future<void> editProfile(User user) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.grey200,
      builder: (context) => DraggableScrollableSheet(
        minChildSize: 0.3,
        maxChildSize: 1,
        initialChildSize: 1,
        builder: (context, scrollController) => EditProfilePage(user: user),
      ),
    );
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
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => Positioned.fill(
              top: 40,
              right: 20,
              child: Row(
                children: [
                  GestureDetector(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: userBloc.user != null &&
                                userBloc.user!.image.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: CacheImage(
                                  imageUrl: userBloc.user?.image ?? '',
                                  height: 80,
                                  width: 80,
                                ),
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.white,
                                ),
                                child: const AppIcon(
                                  icon: AppIcons.profile,
                                  color: AppColors.blue,
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        userBloc.user != null
                            ? 'welcome'.localize(context)
                            : 'personalAccount'.localize(context),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: Fontsize.big),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (userBloc.user == null) {
                                authenticate();
                              }
                            },
                            child: Text(
                              userBloc.user != null
                                  ? '${userBloc.user?.firstName} | '
                                  : '${'createProfile'.localize(context)}  |  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontSize: Fontsize.large),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (userBloc.user != null) {
                                editProfile(userBloc.user!);
                              } else {
                                authenticate();
                              }
                            },
                            child: Text(
                              userBloc.user != null
                                  ? 'editProfile'.localize(context)
                                  : 'login'.localize(context),
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .copyWith(fontSize: Fontsize.large),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
