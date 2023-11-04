import 'package:al_qamar/data/datasources/live_datasource.dart';
import 'package:al_qamar/models/live.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ILiveRepository {
  Future<Either<String, List<Live>>> getVideo();
  Future<Either<String, List<Live>>> getAudio();
}

class LiveRepositoryImpl implements ILiveRepository {
  final LiveDatasource _datasource;
  LiveRepositoryImpl(this._datasource);

  @override
  Future<Either<String, List<Live>>> getAudio() async {
    try {
      Response response = await _datasource.getAudio();
      return right(await compute(_live, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }

  @override
  Future<Either<String, List<Live>>> getVideo() async {
    try {
      Response response = await _datasource.getVideo();
      return right(await compute(_live, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

List<Live> _live(Response response) {
  List<Live> liveList =
      response.data['data'].map<Live>((e) => Live.fromMapJson(e)).toList();

  return liveList;
}
