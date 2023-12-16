import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/pdf_cubit.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfItemWidget extends StatelessWidget {
  const PdfItemWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfCubit, int>(
      builder: (context, state) => ListTile(
        onTap: () => BlocProvider.of<PdfCubit>(context).chnageIndex(index),
        selected: state == index,
        tileColor: AppColors.white,
        selectedTileColor: AppColors.red,
        textColor: AppColors.black,
        selectedColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        leading: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppIcon(
                icon: AppIcons.pdf,
                width: 30,
                height: 30,
                color: state == index ? AppColors.white : AppColors.black,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${'document'.localize(context)} ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // Text(
                  //   '123.6 MB',
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .titleMedium!
                  //       .copyWith(fontSize: 13),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
