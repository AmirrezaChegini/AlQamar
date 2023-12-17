import 'dart:io';

import 'package:al_qamar/bloc/download/download_event.dart';
import 'package:al_qamar/bloc/download/download_state.dart';
import 'package:al_qamar/service/download_service.dart';
import 'package:al_qamar/utils/download_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  final DownloadService _downloadService;
  final DownloadPath _downloadPath;

  DownloadBloc(this._downloadService, this._downloadPath)
      : super(InitDownloadState()) {
    on<StartDownloadEvent>((event, emit) async {
      _downloadService.download(url: event.url, fileName: event.fileName);

      await emit
          .forEach(
            _downloadService.downloadStream,
            onData: (progress) {
              return DownloadingState(progress);
            },
          )
          .onError((error, stackTrace) => emit(FailDownloadState()))
          .whenComplete(() => emit(CompleteDownloadState()));
    });

    on<CheckDownloadedEvent>((event, emit) async {
      String filePath =
          '${await _downloadPath.getDownloadPath()}/${event.fileName}';

      if (File(filePath).existsSync()) {
        emit(CompleteDownloadState());
      } else {
        emit(InitDownloadState());
      }
    });
  }
}
