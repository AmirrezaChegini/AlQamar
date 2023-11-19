import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/models/salavat.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> initDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SalavatAdapter());
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Salavat>('salavatBox');
  await Hive.openBox<Article>('bookmarkBox');
  await Hive.openBox<Article>('favoriteBox');
}
