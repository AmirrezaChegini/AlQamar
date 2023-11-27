import 'package:al_qamar/models/salavat.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

abstract class SalavatDatasource {
  List<Salavat> getAllSalavats();
  Future<void> addSalavat({required Salavat salavat});
  Future<void> removeSalavat({required Salavat salavat});
}

class SalavatLocal implements SalavatDatasource {
  final Box<Salavat> _salavatBox = Hive.box<Salavat>('salavatBox');

  @override
  Future<void> addSalavat({required Salavat salavat}) async {
    try {
      await _salavatBox.put(salavat.id, salavat);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  List<Salavat> getAllSalavats() {
    return _salavatBox.values.toList();
  }

  @override
  Future<void> removeSalavat({required Salavat salavat}) async {
    await _salavatBox.delete(salavat.id);
  }
}
