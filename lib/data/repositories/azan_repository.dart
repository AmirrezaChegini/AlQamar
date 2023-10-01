import 'package:al_qamar/data/datasources/azan_datasource.dart';
import 'package:al_qamar/models/azan_time.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dartz/dartz.dart';

abstract class IAzanRepository {
  Future<Either<String, AzanTime>> getAzanTime(
      {required String city, required String country});
}

class AzanRepositoryImpl implements IAzanRepository {
  final AzanDatasource _datasource;

  AzanRepositoryImpl(this._datasource);

  @override
  Future<Either<String, AzanTime>> getAzanTime(
      {required String city, required String country}) async {
    try {
      AzanTime todayAzanTime = await _datasource.getAzanTime(
        city: city,
        country: country,
      );

      return right(todayAzanTime);
    } on AppExceptions catch (e) {
      return left(e.message);
    }
  }
}
