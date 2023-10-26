import 'package:al_qamar/models/article.dart';

abstract class NewsState {}

class InitNewsState extends NewsState {}

class LoadingNewsState extends NewsState {}

class MoreLoadingNewsState extends NewsState {}

class CompleteNewsState extends NewsState {
  final List<Article> articleList;
  CompleteNewsState(this.articleList);
}

class FailNewsState extends NewsState {
  final String errorMessage;
  FailNewsState(this.errorMessage);
}
