import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
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
        // suffixIconConstraints: const BoxConstraints(
        //   maxHeight: 20,
        //   maxWidth: 100,
        //   minHeight: 20,
        //   minWidth: 0,
        // ),
        suffixIcon: IconBtn(
          onTap: () {},
          child: const AppIcon(
            icon: AppIcons.close,
            width: 20,
            height: 20,
            color: AppColors.red,
          ),
        ),
      ),
    );
  }
}
