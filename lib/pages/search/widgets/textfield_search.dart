import 'package:al_qamar/bloc/search/search_bloc.dart';
import 'package:al_qamar/bloc/search/search_event.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/fontsize.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class TextfielfSearch extends StatefulWidget {
  const TextfielfSearch({
    super.key,
    required this.edtCtrl,
  });

  final TextEditingController edtCtrl;

  @override
  State<TextfielfSearch> createState() => _TextfielfSearchState();
}

class _TextfielfSearchState extends State<TextfielfSearch> {
  final searchText = BehaviorSubject<String>();

  @override
  void initState() {
    super.initState();
    final debouncedSearch =
        searchText.debounceTime(const Duration(seconds: 1)).distinct();

    debouncedSearch.listen((event) {
      BlocProvider.of<SearchBloc>(context).add(SearchArticleEvent(event));
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.edtCtrl,
      keyboardType: TextInputType.text,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: Fontsize.huge),
      onChanged: (value) {
        searchText.add(value);
      },
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
          onTap: () => widget.edtCtrl.clear(),
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
