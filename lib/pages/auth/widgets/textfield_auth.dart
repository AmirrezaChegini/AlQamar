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
    this.obsecure = false,
    this.enabled = true,
    this.suffixIcon,
  });

  final Function(String) validate;
  final String hint;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController controller;
  final bool obsecure;
  final bool enabled;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: inputAction,
      enabled: enabled,
      obscureText: obsecure,
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
            Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14),
        hintText: hint,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
