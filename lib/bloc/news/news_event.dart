abstract class NewsEvent {}

class GetAllArticlesEvent extends NewsEvent {
  final int page;
  GetAllArticlesEvent(this.page);
}

class GetArticleByCategoryEVent extends NewsEvent {
  final int categoryID;
  GetArticleByCategoryEVent(this.categoryID);
}
