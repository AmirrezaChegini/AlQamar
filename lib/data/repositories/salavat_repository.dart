import 'package:al_qamar/data/datasources/salavat_datasource.dart';
import 'package:al_qamar/models/salavat.dart';

abstract class ISalavatRepository {
  List<Salavat> getAllSalavats();
  Future<void> addSalavat({required Salavat salavat});
  Future<void> removeSalavat({required Salavat salavat});
}

class SalavatRepositoryImpl implements ISalavatRepository {
  final SalavatDatasource _datasource;
  SalavatRepositoryImpl(this._datasource);

  @override
  Future<void> addSalavat({required Salavat salavat}) async {
    await _datasource.addSalavat(salavat: salavat);
  }

  @override
  List<Salavat> getAllSalavats() {
    return _datasource.getAllSalavats();
  }

  @override
  Future<void> removeSalavat({required Salavat salavat}) async {
    await _datasource.removeSalavat(salavat: salavat);
  }
}
