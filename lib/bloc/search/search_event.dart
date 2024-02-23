sealed class SearchEvent {}

class SearchArticleEvent extends SearchEvent {
  final String searchText;
  SearchArticleEvent(this.searchText);
}
