import 'package:al_qamar/data/datasources/category_datasource.dart';
import 'package:al_qamar/models/category.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:al_qamar/utils/error_handling/app_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' hide Category;

abstract class ICategoryRepository {
  Future<ApiModel<List<Category>, String>> getAllCategories();
}

class CategoryRepositoryImpl implements ICategoryRepository {
  final CategoryDatasource _datasource;
  CategoryRepositoryImpl(this._datasource);

  @override
  Future<ApiModel<List<Category>, String>> getAllCategories() async {
    try {
      Response response = await _datasource.getAllCategories();
      return ApiModel.success(await compute(categoryList, response));
    } on AppExceptions catch (e) {
      return ApiModel.error(e.message);
    }
  }
}

List<Category> categoryList(Response response) {
  List<Category> categories = response.data['data']['data']
      .map<Category>((e) => Category.fromMapJson(e))
      .toList();

  return categories;
}
