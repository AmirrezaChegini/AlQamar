sealed class NewsEvent {}

class GetAllArticlesEvent extends NewsEvent {
  final int page;
  GetAllArticlesEvent(this.page);
}

class GetArticleByCategoryEVent extends NewsEvent {
  final String categoryID;
  final int page;
  GetArticleByCategoryEVent(this.categoryID, this.page);
}
