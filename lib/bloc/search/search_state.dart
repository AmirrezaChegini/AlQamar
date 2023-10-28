import 'package:al_qamar/models/article.dart';

abstract class SearchState {}

class InitSearchState extends SearchState {}

class LoadingSearchState extends SearchState {}

class CompleteSearchState extends SearchState {
  final List<Article> articleList;
  CompleteSearchState(this.articleList);
}

class FailSearchState extends SearchState {
  final String errorMessage;
  FailSearchState(this.errorMessage);
}
