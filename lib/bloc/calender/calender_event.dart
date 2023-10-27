abstract class CalenderEvent {}

class GetCalenderEvent extends CalenderEvent {
  final String day;
  GetCalenderEvent(this.day);
}
