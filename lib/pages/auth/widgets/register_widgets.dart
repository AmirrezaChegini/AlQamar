import 'package:al_qamar/bloc/auth/auth_bloc.dart';
import 'package:al_qamar/bloc/auth/auth_event.dart';
import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterWidgets extends StatelessWidget {
  RegisterWidgets({
    super.key,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;

  String? validateName(String v) {
    if (v.isEmpty) {
      return 'Enter your Name.';
    }

    return null;
  }

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

  void register(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(
          RegisterAuthEvent(nameCtrl.text, emailCtrl.text, passwordCtrl.text));
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
            controller: nameCtrl,
            validate: (v) => validateName(v),
            hint: 'اسم',
            inputAction: TextInputAction.next,
            inputType: TextInputType.name,
          ),
          const SizedBox(height: 15),
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
            obsecure: true,
          ),
          const Spacer(),
          BtnAuth(
            onTap: () => register(context),
            title: 'المرحلة التالیة',
          ),
        ],
      ),
    );
  }
}
