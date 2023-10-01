import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/svg_icon.dart';
import 'package:flutter/material.dart';

class TextfielfSearch extends StatelessWidget {
  const TextfielfSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.grey600,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: AppColors.grey600,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        suffixIconConstraints: const BoxConstraints(
          maxHeight: 20,
          maxWidth: 100,
          minHeight: 20,
          minWidth: 0,
        ),
        suffixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SvgIcon(
            icon: AppIcons.close,
            width: 10,
            height: 10,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
