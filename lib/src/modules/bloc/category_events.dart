import 'package:equatable/equatable.dart';

abstract class CategoryEvents extends Equatable {
  CategoryEvents([List props = const []]) : super(props);
}

class FetchCategoriesEvent extends CategoryEvents {

  FetchCategoriesEvent();

  @override
  String toString() => 'FetchCategotiesEvent';
}

