import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/cubit/password_cubit.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidgets extends StatelessWidget {
  LoginWidgets({
    super.key,
    required this.emailCtrl,
    required this.passwordCtrl,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;

  String? validateEmail(String v, BuildContext context) {
    bool isMatch = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    ).hasMatch(v);

    if (v.isEmpty) {
      return 'enterEmail'.localize(context);
    } else if (!isMatch) {
      return 'emailInCorrect'.localize(context);
    }

    return null;
  }

  String? validatePassword(String v, BuildContext context) {
    if (v.isEmpty) {
      return 'enterPassword'.localize(context);
    } else if (v.length < 8) {
      return 'passwordInCorrect'.localize(context);
    }

    return null;
  }

  void login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context)
          .add(LoginAuthEvent(emailCtrl.text, passwordCtrl.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFieldAuth(
            controller: emailCtrl,
            validate: (v) => validateEmail(v, context),
            hint: 'email'.localize(context),
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          BlocBuilder<PasswordCubit, bool>(
            builder: (context, state) => TextFieldAuth(
              controller: passwordCtrl,
              validate: (v) => validatePassword(v, context),
              hint: 'password'.localize(context),
              inputAction: TextInputAction.done,
              inputType: TextInputType.name,
              obsecure: state,
              suffixIcon: IconBtn(
                onTap: () => BlocProvider.of<PasswordCubit>(context)
                    .changeVisible(!state),
                child: Icon(
                  state
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.grey600,
                ),
              ),
            ),
          ),
          const Spacer(),
          BtnAuth(
            onTap: () => login(context),
            title: 'login'.localize(context),
          ),
        ],
      ),
    );
  }
}
