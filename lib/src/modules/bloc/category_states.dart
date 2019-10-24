import 'package:equatable/equatable.dart';
import 'package:meals/src/services/models/category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryState extends Equatable {
  CategoryState([List props = const []]) : super(props);
}

class CategoryLoadingState extends CategoryState {
  @override
  String toString() => 'CategoryLoadingState';
}

class CategoryLoadedState extends CategoryState {
  final List<Category> categories;

  CategoryLoadedState(this.categories) : super([categories]);

  @override
  String toString() => 'CategoryLoadedState: $categories';
}

class CategoryErrorState extends CategoryState {
  final Exception error;

  CategoryErrorState(this.error) : super([error]);

  @override
  String toString() => 'CategoryErrorState: $error';
}
