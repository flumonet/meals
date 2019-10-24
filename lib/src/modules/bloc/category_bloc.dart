import 'package:bloc/bloc.dart';
import 'package:meals/src/modules/bloc/category_events.dart';
import 'package:meals/src/services/api/categories_service.dart';

import 'category_states.dart';

class CategoryBloc extends Bloc<CategoryEvents, CategoryState> {
  final CategoriesService _categoriesService;

  CategoryBloc(this._categoriesService);

  @override
  get initialState => CategoryLoadingState();

  @override
  Stream<CategoryState> mapEventToState(CategoryEvents event) async* {
    if (event is FetchCategoriesEvent) {
      yield* _getCategories();
    }
  }


  Stream<CategoryState> _getCategories() async* {
    yield CategoryLoadingState();
    try {
      var categories = await _categoriesService.fetchCategories();
      yield CategoryLoadedState(categories);
    } catch (e) {
      yield CategoryErrorState(e);
    }
  }
}
