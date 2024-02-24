import 'package:al_qamar/data/datasources/live_datasource.dart';
import 'package:al_qamar/models/live.dart';
import 'package:al_qamar/models/program_time.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ILiveRepository {
  Future<ApiModel<List<Live>, String>> getLive();
  Future<ApiModel<List<ProgramTime>, String>> getProgram();
}

class LiveRepositoryImpl implements ILiveRepository {
  final LiveDatasource _datasource;
  LiveRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<List<Live>, String>> getLive() async {
    try {
      return ApiModel.success(
        await compute(
          _live,
          await _datasource.getLive(),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }

  @override
  Future<ApiModel<List<ProgramTime>, String>> getProgram() async {
    try {
      return ApiModel.success(
        await compute(
          _program,
          await _datasource.getprogram(),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

List<Live> _live(Response response) {
  return response.data['items'].map<Live>((e) => Live.fromMapJson(e)).toList();
}

List<ProgramTime> _program(Response response) {
  return response.data['items']
      .map<ProgramTime>((e) => ProgramTime.fromMapJson(e))
      .toList();
}
