import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../features/favorites/data/datasource/favorites_datasource.dart';
import '../features/favorites/data/repositories/favorites_repository_impl.dart';
import '../features/favorites/domain/repository/favorites_repository.dart';
import '../features/favorites/domain/usecase/get_favorites.dart';
import '../features/favorites/domain/usecase/update_favorite.dart';
import '../features/favorites/presentation/bloc/favorites_bloc.dart';
import '../features/main_page/presentation/bloc/main_bloc.dart';
import '../features/translate/data/datasource/translate_datasource.dart';
import '../features/translate/data/repository/translate_repository_impl.dart';
import '../features/translate/domain/repository/translate_repository.dart';
import '../features/translate/domain/usecase/get_languages_usecase.dart';
import '../features/translate/presentation/bloc/translate_bloc.dart';
import '../resources/network/network_constants.dart';
import 'db/hive_db_wrapper.dart';
import 'network/network_info.dart';
import 'repository/repository.dart';
import 'singleton/user_details.dart';

final di = GetIt.instance;

Future<void> init() async {
  di.registerFactory(() => MainBloc(
      languagesUseCase: di(), sharedPreferences: di(), getFavorites: di()));
  /*---------------Translate--------------------*/
  di.registerFactory(() => TranslateDataSource());
  di.registerFactory<TranslateRepository>(
      () => TranslateRepositoryImpl(dataSource: di(), repository: di()));
  di.registerFactory(() => GetLanguagesUseCase(repository: di()));
  di.registerFactory(() => TranslateBloc(
      languagesUseCase: di(), sharedPreferences: di(), updateFavorite: di()));
  /*---------------Favorites--------------------*/
  di.registerFactory(() => FavoritesLocalDataSource(hive: di()));
  di.registerFactory<FavoritesRepository>(
      () => FavoritesRepositoryImpl(dataSource: di()));
  di.registerFactory(() => GetFavorites(repository: di()));
  di.registerFactory(() => UpdateFavorites(repository: di()));
  di.registerFactory(() => FavoritesBloc(updateFavorites: di()));
  /*------------Singletons-------*/
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfo());
  di.registerLazySingleton<HiveDBWrapper>(() => HiveDBWrapper());
  di.registerLazySingleton<NetworkConstants>(() => NetworkConstants());
  di.registerFactory(() => Repository(networkInfo: di()));
  final sharedPreference = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => sharedPreference);
  di.registerLazySingleton<UserDetails>(() => UserDetails());
}
