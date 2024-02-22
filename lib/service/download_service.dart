import 'dart:async';

import 'package:al_qamar/utils/download_path.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DownloadService {
  final Dio _dio;
  final DownloadPath _downloadPath;
  StreamController<double> streamCtrl = StreamController.broadcast();

  DownloadService(this._dio, this._downloadPath);

  Stream<double> get downloadStream => streamCtrl.stream.asBroadcastStream();

  Future<void> download({required String url, required String fileName}) async {
    try {
      await _dio.download(
        url,
        '${await _downloadPath.getDownloadPath()}/$fileName',
        onReceiveProgress: (recieved, total) {
          streamCtrl.add(recieved / total);
          if (recieved / total >= 1) {
            streamCtrl.close();
          }
        },
      );
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
