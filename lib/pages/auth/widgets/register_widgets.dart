import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:al_qamar/pages/auth/widgets/textfield_auth.dart';
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
        // TextFieldAuth(
        //   validate: (p0) {},
        //   hint: 'اسم',
        //   inputAction: TextInputAction.next,
        //   inputType: TextInputType.name,
        // ),
        // const SizedBox(height: 15),
        // TextFieldAuth(
        //   validate: (p0) {},
        //   hint: 'بريد إلكتروني',
        //   inputAction: TextInputAction.next,
        //   inputType: TextInputType.name,
        // ),
        // const SizedBox(height: 15),
        // TextFieldAuth(
        //   validate: (p0) {},
        //   hint: 'كلمة المرور',
        //   inputAction: TextInputAction.next,
        //   inputType: TextInputType.name,
        // ),
        Text(
          'ادخل کلمة المرور مرسنة',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
        ),
        const SizedBox(height: 20),
        Form(
          child: Row(
            children: List.generate(
              6,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      cursorHeight: 20,
                      onChanged: (value) {
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontSize: 14),
                      decoration: const InputDecoration(
                        counterText: '',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'ادخل کلمة المرور بعد 20 ثانیه',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
        ),
        const Spacer(),
        BtnAuth(
          onTap: () {},
          title: 'المرحلة التالیة',
        ),
      ],
    );
  }
}
