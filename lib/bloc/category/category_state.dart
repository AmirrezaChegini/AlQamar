import 'package:al_qamar/models/category.dart';

sealed class CategorySate {}

class InitCategoryState extends CategorySate {}

class CompleteCategoryState extends CategorySate {
  final List<Category> categoryList;
  CompleteCategoryState(this.categoryList);
}

class FailCategoryState extends CategorySate {
  final String errorMessage;
  FailCategoryState(this.errorMessage);
}
