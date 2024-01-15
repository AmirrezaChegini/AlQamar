import 'package:al_qamar/constants/fontsize.dart';
import 'package:flutter/material.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      maxLength: 1,
      keyboardType: TextInputType.number,
      onChanged: (value) => onChanged(value),
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: Fontsize.huge),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.all(0),
        counterText: '',
      ),
    );
  }
}
