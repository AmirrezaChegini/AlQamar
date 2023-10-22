import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/cubit/audio_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioWidget extends StatelessWidget {
  const AudioWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioCubit, int>(
      builder: (context, state) => ListTile(
        onTap: () => BlocProvider.of<AudioCubit>(context).chnageIndex(index),
        selected: state == index,
        tileColor: AppColors.white,
        selectedTileColor: AppColors.red100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        leading: SizedBox(
          width: MediaQuery.sizeOf(context).width / 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${'audio'.localize(context)} ${index + 1}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      color: state == index ? AppColors.red : AppColors.black,
                    ),
              ),
              // Text(
              //   '01:22:32',
              //   style: Theme.of(context)
              //       .textTheme
              //       .titleMedium!
              //       .copyWith(fontSize: 13),
              // ),
            ],
          ),
        ),
        // trailing: const IconAnimated(
        //   icon: AnimatedIcons.play_pause,
        //   state: false,
        // ),
      ),
    );
  }
}
