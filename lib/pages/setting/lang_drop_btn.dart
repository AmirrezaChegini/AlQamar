import 'package:al_qamar/cubit/localize_cubit.dart';
import 'package:al_qamar/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LangDropBtn extends StatelessWidget {
  const LangDropBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizeCubit, String>(
      builder: (context, state) => DropdownButton(
        onChanged: (value) async {
          await Storage.saveString(key: 'lang', value: value!).then(
              (value) => BlocProvider.of<LocalizeCubit>(context).getLang());
        },
        value: state,
        underline: const SizedBox(),
        items: const [
          DropdownMenuItem(
            value: 'system',
            child: Row(
              children: [
                Text('Default'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'ar',
            child: Row(
              children: [
                Text('🇸🇦'),
                SizedBox(width: 6),
                Text('Ar'),
              ],
            ),
          ),
          DropdownMenuItem(
            value: 'en',
            child: Row(
              children: [
                Text('🇬🇧'),
                SizedBox(width: 6),
                Text('En'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
