// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'injector.dart';

// **************************************************************************
// InjectorGenerator
// **************************************************************************

class _$Injector extends Injector {
  void configure() {
    final Container container = Container();
    container.registerFactory((c) => Client(), name: 'client');
    container.registerFactory<CategoriesService, CategoriesApiService>(
        (c) => CategoriesApiService());
    container.registerFactory((c) => CategoryBloc(c<CategoriesService>()));
  }
}
