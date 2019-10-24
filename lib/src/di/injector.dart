import 'package:http/http.dart';
import 'package:kiwi/kiwi.dart';
import 'package:meals/src/modules/bloc/category_bloc.dart';
import 'package:meals/src/services/api/categories_api_service.dart';
import 'package:meals/src/services/api/categories_service.dart';

part 'injector.g.dart';

abstract class Injector {
  @Register.factory(
    Client,
    name: 'client',
  )
  @Register.factory(
    CategoriesService,
    from: CategoriesApiService,
    resolvers: {
      Client: 'client',
    },
  )
  @Register.factory(CategoryBloc)

  void configure();

  static void inject() {
    _$Injector()..configure();
  }
}
