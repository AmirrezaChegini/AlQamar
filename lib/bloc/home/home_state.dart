import 'package:al_qamar/models/article.dart';
import 'package:al_qamar/models/force_article.dart';

sealed class HomeState {}

class InitHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class CompleteHomeState extends HomeState {
  final List<Article> articleList;
  final List<ForceArticle> forceArticleList;
  CompleteHomeState(this.articleList, this.forceArticleList);
}

class FailHomeState extends HomeState {
  final String errorMessage;
  FailHomeState(this.errorMessage);
}
