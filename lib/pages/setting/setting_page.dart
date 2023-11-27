import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/bloc/user/user_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/pages/setting/widgets/lang_drop_btn.dart';
import 'package:al_qamar/widgets/app_snackbar.dart';
import 'package:al_qamar/widgets/main_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      appBar: MainAppbar(
        title: 'setting'.localize(context),
        appbarLeading: BackButton(
          onPressed: () => Navigator.pop(context),
          color: AppColors.red,
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is InitAuthState) {
            showMessage(
              context: context,
              content: 'logoutSuccess'.localize(context),
              horizontalMargin: 10,
              verticalMargin: 10,
              isError: false,
            );

            BlocProvider.of<UserBloc>(context).add(GetUserEvent());
          }

          if (state is FailAuthState) {
            showMessage(
              context: context,
              content: state.errorMessage.localize(context),
              horizontalMargin: 10,
              verticalMargin: 10,
            );
          }
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: ListTile(
                tileColor: AppColors.white,
                title: Text('language'.localize(context)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                trailing: const LangDropBtn(),
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is CompleteUserState) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () => BlocProvider.of<AuthBloc>(context)
                          .add(LogoutAuthEvent()),
                      tileColor: AppColors.white,
                      title: Text('logout'.localize(context)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
