import 'package:al_qamar/bloc/download/download_bloc.dart';
import 'package:al_qamar/bloc/download/download_event.dart';
import 'package:al_qamar/bloc/download/download_state.dart';
import 'package:al_qamar/config/localize.dart';
import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/constants/icons.dart';
import 'package:al_qamar/cubit/pdf_cubit.dart';
import 'package:al_qamar/utils/extensions/string.dart';
import 'package:al_qamar/utils/permission_handler.dart';
import 'package:al_qamar/widgets/app_icon.dart';
import 'package:al_qamar/widgets/icon_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PdfItemWidget extends StatefulWidget {
  const PdfItemWidget({
    super.key,
    required this.index,
    required this.url,
  });

  final int index;
  final String url;

  @override
  State<PdfItemWidget> createState() => _PdfItemWidgetState();
}

class _PdfItemWidgetState extends State<PdfItemWidget> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DownloadPdfBloc>(context)
        .add(CheckDownloadedPdfEvent(widget.url.getFilename()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PdfCubit, int>(
      builder: (context, state) => ListTile(
        onTap: () =>
            BlocProvider.of<PdfCubit>(context).chnageIndex(widget.index),
        selected: state == widget.index,
        tileColor: AppColors.white,
        selectedTileColor: AppColors.red,
        textColor: AppColors.black,
        selectedColor: AppColors.white,
        trailing: SizedBox(
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<DownloadPdfBloc, DownloadPdfState>(
                builder: (context, innerState) {
                  if (innerState is CompleteDownloadPdfState) {
                    return AppIcon(
                      icon: AppIcons.downloaded,
                      width: 25,
                      height: 25,
                      color: state == widget.index
                          ? AppColors.white
                          : AppColors.black,
                    );
                  } else {
                    return IconBtn(
                      onTap: () async {
                        await storagePermission().then((value) {
                          if (value) {
                            BlocProvider.of<DownloadPdfBloc>(context).add(
                              StartDownloadPdfEvent(
                                widget.url,
                                widget.url.getFilename(),
                              ),
                            );
                          }
                        });
                      },
                      child: AppIcon(
                        icon: AppIcons.downloading,
                        width: 25,
                        height: 25,
                        color: state == widget.index
                            ? AppColors.white
                            : AppColors.black,
                      ),
                    );
                  }
                },
              ),
              BlocBuilder<DownloadPdfBloc, DownloadPdfState>(
                builder: (context, innerState) {
                  if (innerState is DownloadingPdfState) {
                    return LinearProgressIndicator(
                      value: innerState.progress,
                      borderRadius: BorderRadius.circular(20),
                      backgroundColor: AppColors.grey600,
                      color: state == widget.index
                          ? AppColors.white
                          : AppColors.black,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
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
                color:
                    state == widget.index ? AppColors.white : AppColors.black,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${'document'.localize(context)} ${widget.index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
