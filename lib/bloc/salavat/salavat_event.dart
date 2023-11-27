import 'package:al_qamar/models/salavat.dart';

abstract class SalavatEvent {}

class GetAllSalavatEvent extends SalavatEvent {}

class AddSalavatEvent extends SalavatEvent {
  final Salavat salavat;
  AddSalavatEvent(this.salavat);
}

class RemoveSalavatEvent extends SalavatEvent {
  final Salavat salavat;
  RemoveSalavatEvent(this.salavat);
}
