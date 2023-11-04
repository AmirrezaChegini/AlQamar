import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_state.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BtnAuth extends StatelessWidget {
  const BtnAuth({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(160, 40),
        backgroundColor: AppColors.blue,
        foregroundColor: AppColors.white,
        textStyle:
            Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 11),
      ),
      child: Row(
        children: [
          const Spacer(),
          Text(title),
          const Spacer(),
          const VerticalDivider(
            color: AppColors.white,
            thickness: 1,
            indent: 8,
            endIndent: 8,
          ),
          const Spacer(),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) =>
                state is LoadingAuthState || state is LoadingVerifyState
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const AppIcon(
                        icon: AppIcons.rightArrow,
                        color: AppColors.white,
                        height: 20,
                        width: 20,
                        matchDirection: true,
                      ),
          ),
        ],
      ),
    );
  }
}
