import 'package:al_qamar/data/datasources/calender_datasource.dart';
import 'package:al_qamar/models/calender.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ICalenderRepository {
  Future<ApiModel<List<Calender>, String>> getCalender({required String day});
}

class CalenderRepositoryImpl implements ICalenderRepository {
  final CalenderDatasource _datasource;
  CalenderRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<List<Calender>, String>> getCalender(
      {required String day}) async {
    try {
      Response response = await _datasource.getCalender(day: day);

      return ApiModel.success(await compute(_calender, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
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
