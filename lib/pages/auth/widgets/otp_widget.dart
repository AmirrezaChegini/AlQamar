import 'package:al_qamar/pages/auth/widgets/btn_auth.dart';
import 'package:flutter/material.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ادخل کلمة المرور المرسنة',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
        ),
        Row(
          children: List.generate(
            6,
            (index) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  maxLength: 1,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      FocusScope.of(context).previousFocus();
                    }
                    if (value.isEmpty) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 22),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    counterText: '',
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'اعادة ارسالة کلمة المرور بعد 20 ثانیه',
          style:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
        ),
        const Spacer(),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: BtnAuth(
            onTap: () {
              Navigator.pop(context);
            },
            title: 'المرحلة التالیة',
          ),
        ),
      ],
    );
  }
}
