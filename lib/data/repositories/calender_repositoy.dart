import 'package:al_qamar/data/datasources/calender_datasource.dart';
import 'package:al_qamar/models/calender.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ICalenderRepository {
  Future<ApiModel<List<Calender>, String>> getAllCalender(
      {required DateTime day});
}

class CalenderRepositoryImpl implements ICalenderRepository {
  final CalenderDatasource _datasource;
  CalenderRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<List<Calender>, String>> getAllCalender(
      {required DateTime day}) async {
    try {
      return ApiModel.success(
        await compute(
          _calenders,
          await _datasource.getAllCalender(day: day),
        ),
      );
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

List<Calender> _calenders(Response response) {
  return response.data['items']
      .map<Calender>((e) => Calender.fromMapJson(e))
      .toList();
}
