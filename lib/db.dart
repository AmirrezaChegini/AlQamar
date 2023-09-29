import 'package:al_qamar/models/salavat.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> initDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SalavatAdapter());
  await Hive.openBox<Salavat>('salavatBox');
}
