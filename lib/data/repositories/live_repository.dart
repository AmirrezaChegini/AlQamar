import 'package:al_qamar/data/datasources/live_datasource.dart';
import 'package:al_qamar/models/live.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ILiveRepository {
  Future<ApiModel<List<Live>, String>> getVideo();
  Future<ApiModel<List<Live>, String>> getAudio();
  Future<ApiModel<List<Live>, String>> getAllPrograms();
}

class LiveRepositoryImpl implements ILiveRepository {
  final LiveDatasource _datasource;
  LiveRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<List<Live>, String>> getAudio() async {
    try {
      Response response = await _datasource.getAudio();
      return ApiModel.success(await compute(_live, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Live>, String>> getVideo() async {
    try {
      Response response = await _datasource.getVideo();
      return ApiModel.success(await compute(_live, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<Live>, String>> getAllPrograms() async {
    try {
      List<Live> allProgramList = [];
      Response videoResponse = await _datasource.getVideo();
      Response audioResponse = await _datasource.getAudio();

      List<Live> videoList = await compute(_live, videoResponse);
      List<Live> audioList = await compute(_live, audioResponse);

      allProgramList.addAll(videoList);
      allProgramList.addAll(audioList);

      return ApiModel.success(allProgramList);
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

List<Live> _live(Response response) {
  List<Live> liveList =
      response.data['data'].map<Live>((e) => Live.fromMapJson(e)).toList();

  return liveList;
}
