sealed class CalenderEvent {}

class GetAllCalenderEvent extends CalenderEvent {
  final DateTime day;
  GetAllCalenderEvent(this.day);
}
