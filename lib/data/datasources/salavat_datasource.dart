import 'package:al_qamar/models/salavat.dart';
import 'package:hive/hive.dart';

abstract class SalavatDatasource {
  List<Salavat> getAllSalavats();
  Future<void> addSalavat({required Salavat salavat});
}

class SalavatLocal implements SalavatDatasource {
  final Box<Salavat> _salavatBox = Hive.box<Salavat>('salavatBox');

  @override
  Future<void> addSalavat({required Salavat salavat}) async {
    try {
      if (_salavatBox.values.length < 3 && salavat.id == -1) {
        await _salavatBox.add(salavat);
      } else {
        await _salavatBox.put(salavat.id, salavat);
      }
    } catch (_) {}
  }

  @override
  List<Salavat> getAllSalavats() {
    return _salavatBox.values.toList();
  }
}
