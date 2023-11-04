import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/constants/images.dart';
import 'package:al_qamar/models/user.dart';
import 'package:al_qamar/pages/auth/auth_page.dart';
import 'package:al_qamar/pages/profile/edit_profile_page.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:al_qamar/widgets/app_icon.dart';
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
  Future<void> authenticate() async {
    showModalBottomSheet(
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
  }

  Future<void> editProfile(User user) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
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
          Positioned.fill(
            top: 40,
            right: 20,
            left: 20,
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
                    child: const AppIcon(
                      icon: AppIcons.profile,
                      color: AppColors.blue,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) async {
                    if (state is CompleteUserState) {
                      await Future.wait([
                        Storage.removeKey(key: 'email'),
                        Storage.removeKey(key: 'firstName'),
                        Storage.removeKey(key: 'lastName'),
                      ]);
                    }
                  },
                  builder: (context, state) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state is CompleteUserState
                            ? 'welcome'.localize(context)
                            : 'personalAccount'.localize(context),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          state is CompleteUserState
                              ? editProfile(state.user)
                              : authenticate();
                        },
                        child: Text.rich(
                          TextSpan(
                            text: state is CompleteUserState
                                ? '${state.user.firstName} | '
                                : '${'createProfile'.localize(context)}  |  ',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontSize: 14),
                            children: [
                              TextSpan(
                                text: state is CompleteUserState
                                    ? 'editProfile'.localize(context)
                                    : 'login'.localize(context),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
