import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldAuth extends StatelessWidget {
  const TextFieldAuth({
    super.key,
    required this.validate,
    required this.hint,
    required this.inputType,
    required this.inputAction,
  });

  final Function(String) validate;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: inputAction,
      validator: (value) => validate(value!),
      cursorColor: AppColors.blue,
      cursorHeight: 20,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.grey,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blue,
          ),
        ),
        hintText: hint,
      ),
    );
  }
}
