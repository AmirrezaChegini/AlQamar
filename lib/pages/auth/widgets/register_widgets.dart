import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterWidgets extends StatelessWidget {
  RegisterWidgets({
    super.key,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;

  String? validateName(String v, BuildContext context) {
    if (v.isEmpty) {
      return 'enterName'.localize(context);
    }

    return null;
  }

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

  void register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
        RegisterAuthEvent(
          '${firstNameCtrl.text} ${lastNameCtrl.text}',
          emailCtrl.text,
          passwordCtrl.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFieldAuth(
            controller: firstNameCtrl,
            validate: (v) => validateName(v, context),
            hint: 'firstname'.localize(context),
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          TextFieldAuth(
            controller: lastNameCtrl,
            validate: (v) => validateName(v, context),
            hint: 'lastname'.localize(context),
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          TextFieldAuth(
            controller: emailCtrl,
            validate: (v) => validateEmail(v, context),
            hint: 'email'.localize(context),
            inputAction: TextInputAction.next,
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 15),
          TextFieldAuth(
            controller: passwordCtrl,
            validate: (v) => validatePassword(v, context),
            hint: 'password'.localize(context),
            inputAction: TextInputAction.next,
            inputType: TextInputType.visiblePassword,
            obsecure: true,
          ),
          const Spacer(),
          BtnAuth(
            onTap: () => register(context),
            title: 'nextPhase'.localize(context),
          ),
        ],
      ),
    );
  }
}
