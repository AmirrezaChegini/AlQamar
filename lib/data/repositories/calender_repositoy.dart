import 'package:al_qamar/data/datasources/calender_datasource.dart';
import 'package:al_qamar/models/calender.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ICalenderRepository {
  Future<Either<String, List<Calender>>> getCalender({required String day});
}

class CalenderRepositoryImpl implements ICalenderRepository {
  final CalenderDatasource _datasource;
  CalenderRepositoryImpl(this._datasource);

  @override
  Future<Either<String, List<Calender>>> getCalender(
      {required String day}) async {
    try {
      Response response = await _datasource.getCalender(day: day);

      return right(await compute(_calender, response));
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}

List<Calender> _calender(Response response) {
  try {
    List<Calender> calenderList = response.data['data']
        .map<Calender>((e) => Calender.fromMapJson(e))
        .toList();

    return calenderList;
  } catch (e) {
    return [];
  }
}
