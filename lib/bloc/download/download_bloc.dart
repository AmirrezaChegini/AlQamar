import 'dart:io';

import 'package:al_qamar/bloc/download/download_event.dart';
import 'package:al_qamar/bloc/download/download_state.dart';
import 'package:al_qamar/service/download_service.dart';
import 'package:al_qamar/utils/download_path.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//audio bloc
class DownloadAudioBloc extends Bloc<DownloadAudioEvent, DownloadAudioState> {
  final DownloadService _downloadService;
  final DownloadPath _downloadPath;

  DownloadAudioBloc(this._downloadService, this._downloadPath)
      : super(InitDownloadAudioState()) {
    on<StartDownloadAudioEvent>((event, emit) async {
      _downloadService.download(url: event.url, fileName: event.fileName);

      await emit
          .forEach(
            _downloadService.downloadStream,
            onData: (progress) {
              return DownloadingAudioState(progress);
            },
          )
          .onError((error, stackTrace) => emit(FailDownloadAudioState()))
          .whenComplete(() => emit(CompleteDownloadAudioState()));
    });

    on<CheckDownloadedAudioEvent>((event, emit) async {
      String filePath =
          '${await _downloadPath.getDownloadPath()}/${event.fileName}';

      if (File(filePath).existsSync()) {
        emit(CompleteDownloadAudioState());
      } else {
        emit(InitDownloadAudioState());
      }
    });
  }
}

//pdf bloc
class DownloadPdfBloc extends Bloc<DownloadPdfEvent, DownloadPdfState> {
  final DownloadService _downloadService;
  final DownloadPath _downloadPath;

  DownloadPdfBloc(this._downloadService, this._downloadPath)
      : super(InitDownloadPdfState()) {
    on<StartDownloadPdfEvent>((event, emit) async {
      _downloadService.download(url: event.url, fileName: event.fileName);

      await emit
          .forEach(
            _downloadService.downloadStream,
            onData: (progress) {
              return DownloadingPdfState(progress);
            },
          )
          .onError((error, stackTrace) => emit(FailDownloadPdfState()))
          .whenComplete(() => emit(CompleteDownloadPdfState()));
    });

    on<CheckDownloadedPdfEvent>((event, emit) async {
      String filePath =
          '${await _downloadPath.getDownloadPath()}/${event.fileName}';

      if (File(filePath).existsSync()) {
        emit(CompleteDownloadPdfState());
      } else {
        emit(InitDownloadPdfState());
      }
    });
  }
}
