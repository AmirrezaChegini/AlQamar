import 'package:al_qamar/models/salavat.dart';

abstract class SalavatState {}

class InitSalavatState extends SalavatState {}

class CompleteSalavatState extends SalavatState {
  final List<Salavat> salavatList;
  CompleteSalavatState(this.salavatList);
}
