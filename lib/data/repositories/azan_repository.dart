import 'package:al_qamar/data/datasources/azan_datasource.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class IAzanRepository {
  Future<Either<String, AzanTime>> getAzanTime({
    required String city,
    required String country,
    required int method,
    required int midnightMode,
    required String tune,
  });
}

class AzanRepositoryImpl implements IAzanRepository {
  final AzanDatasource _datasource;

  AzanRepositoryImpl(this._datasource);

  @override
  Future<Either<String, AzanTime>> getAzanTime({
    required String city,
    required String country,
    required int method,
    required int midnightMode,
    required String tune,
  }) async {
    try {
      Response response = await _datasource.getAzanTime(
        city: city,
        country: country,
        method: method,
        midnightMode: midnightMode,
        tune: tune,
      );

      return right(await compute(_todayAzanTime, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

AzanTime _todayAzanTime(Response response) {
  AzanTime azanTime = AzanTime.fromMapJson(response.data['data']['timings']);

  return azanTime;
}
