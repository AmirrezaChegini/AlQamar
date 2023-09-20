import 'package:al_qamar/pages/account/widgets/btn_auth.dart';
import 'package:al_qamar/pages/account/widgets/textfield_auth.dart';
import 'package:flutter/material.dart';

class RegisterWidgets extends StatelessWidget {
  const RegisterWidgets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFieldAuth(
          validate: (p0) {},
          hint: 'اسم',
          inputAction: TextInputAction.next,
          inputType: TextInputType.name,
        ),
        const SizedBox(height: 15),
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
        const BtnAuth(
          title: 'المرحلة التالیة',
        ),
      ],
    );
  }
}
