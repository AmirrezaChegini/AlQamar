import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
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
        const BtnAuth(),
      ],
    );
  }
}
