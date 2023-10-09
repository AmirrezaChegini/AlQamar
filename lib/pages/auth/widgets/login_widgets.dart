import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
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

  String? validateEmail(String v) {
    bool isMatch = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    ).hasMatch(v);

    if (v.isEmpty) {
      return 'Enter your email.';
    } else if (!isMatch) {
      return 'Your email format is incorrect.';
    }

    return null;
  }

  String? validatePassword(String v) {
    if (v.isEmpty) {
      return 'Enter your Password.';
    } else if (v.length < 8) {
      return 'Your password must be at least 8 characters';
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
            validate: (v) => validateEmail(v),
            hint: 'بريد إلكتروني',
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          TextFieldAuth(
            controller: passwordCtrl,
            validate: (v) => validatePassword(v),
            hint: 'كلمة المرور',
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
          ),
          const Spacer(),
          BtnAuth(
            onTap: () => login(context),
            title: 'تسجیل الدخول',
          ),
        ],
      ),
    );
  }
}
