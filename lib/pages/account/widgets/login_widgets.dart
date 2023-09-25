import 'package:al_qamar/cubit/auth_cubit.dart';
import 'package:al_qamar/pages/account/widgets/btn_auth.dart';
import 'package:al_qamar/pages/account/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFieldAuth(
          validate: (p0) {},
          hint: 'بريد إلكتروني',
          inputAction: TextInputAction.next,
          inputType: TextInputType.name,
        ),
        const SizedBox(height: 15),
        TextFieldAuth(
          validate: (p0) {},
          hint: 'كلمة المرور',
          inputAction: TextInputAction.next,
          inputType: TextInputType.name,
        ),
        const Spacer(),
        BtnAuth(
          onTap: () {
            BlocProvider.of<AuthCubit>(context).signIn(true);
          },
          title: 'تسجیل الدخول',
        ),
      ],
    );
  }
}
