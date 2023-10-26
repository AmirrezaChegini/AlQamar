import 'package:al_qamar/bloc/search/search_bloc.dart';
import 'package:al_qamar/bloc/search/search_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextfielfSearch extends StatelessWidget {
  const TextfielfSearch({
    super.key,
    required this.edtCtrl,
  });

  final TextEditingController edtCtrl;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: edtCtrl,
      keyboardType: TextInputType.text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
      onSubmitted: (value) => BlocProvider.of<SearchBloc>(context)
          .add(SearchArticleEvent(edtCtrl.text)),
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
        suffixIcon: IconBtn(
          onTap: () => edtCtrl.clear(),
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
