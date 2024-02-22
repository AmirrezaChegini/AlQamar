import 'package:al_qamar/bloc/category/category_event.dart';
import 'package:al_qamar/bloc/category/category_state.dart';
import 'package:al_qamar/data/repositories/category_repository.dart';
import 'package:al_qamar/models/category.dart';
import 'package:al_qamar/utils/api_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategorySate> {
  final ICategoryRepository _repository;

  CategoryBloc(this._repository) : super(InitCategoryState()) {
    on<GetAllCategoryEvent>((event, emit) async {
      ApiModel<List<Category>, String> either =
          await _repository.getAllCategories();

      either.fold(
        (data) => emit(CompleteCategoryState(data)),
        (error) => emit(FailCategoryState(error)),
      );
    });
  }
}
