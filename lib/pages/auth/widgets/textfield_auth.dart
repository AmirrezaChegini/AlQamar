import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class TextFieldAuth extends StatelessWidget {
  const TextFieldAuth({
    super.key,
    required this.validate,
    required this.hint,
    required this.inputType,
    required this.inputAction,
    required this.controller,
  });

  final Function(String) validate;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: inputAction,
      validator: (value) => validate(value!),
      cursorColor: AppColors.blue,
      textAlignVertical: TextAlignVertical.bottom,
      style: Theme.of(context).textTheme.displayMedium!.copyWith(fontSize: 14),
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.blue,
          ),
        ),
        hintStyle:
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 12),
        hintText: hint,
      ),
    );
  }
}
