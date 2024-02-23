sealed class ArticleEvent {}

class GetArticleEvent extends ArticleEvent {
  final String articleID;
  GetArticleEvent(this.articleID);
}
