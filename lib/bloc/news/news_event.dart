abstract class NewsEvent {}

class GetAllArticlesEvent extends NewsEvent {
  final int categoryID;
  GetAllArticlesEvent(this.categoryID);
}
