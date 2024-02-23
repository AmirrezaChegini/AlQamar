import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/bloc/user/user_bloc.dart';
import 'package:al_qamar/bloc/user/user_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(
        'logoutMessage'.localize(context),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      alignment: Alignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.red,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          child: Text('cancel'.localize(context)),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AuthBloc>(context).add(LogoutAuthEvent());
            BlocProvider.of<UserBloc>(context).add(LogoutUserEvent());
            Navigator.pop(context);
            Navigator.maybePop(context);
          },
          style: TextButton.styleFrom(
            foregroundColor: AppColors.blue,
            textStyle: Theme.of(context).textTheme.bodyLarge,
          ),
          child: Text('yes'.localize(context)),
        ),
      ],
    );
  }
}
