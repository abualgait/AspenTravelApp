import 'package:aspen_app/core/app_export.dart';
import 'package:aspen_app/core/local/DatabaseHelper.dart';
import 'package:aspen_app/data/datasource/travel/travel_local_data_source.dart';
import 'package:aspen_app/data/datasource/travel/travel_remote_data_source.dart';
import 'package:aspen_app/domain/usecase/get_travel_data.dart';
import 'package:aspen_app/domain/usecase/insert_favorite_city.dart';
import 'package:aspen_app/presentation/home_screen/provider/home_provider.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_manager.dart';
import 'data/repository/travel/travel_repository_impl.dart';
import 'domain/repository/travel/travel_repository.dart';
import 'domain/usecase/get_favorite_data.dart';
import 'domain/usecase/remove_favorite_city.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /**
   * ! Features
   */
  // Bloc
  sl.registerLazySingleton(() => HomeStateNotifier(
      getTravelDataUseCase: sl(),
      addFavoriteCityUseCase: sl(),
      deleteFavoriteCityUseCase: sl(),
      getFavoriteCitiesUseCase: sl()));
  sl.registerLazySingleton(() => ThemeBloc());

  // Use Case
  sl.registerLazySingleton(() => GetTravelDataUseCase(travelRepository: sl()));
  sl.registerLazySingleton(
      () => GetFavoriteCitiesUseCase(travelRepository: sl()));
  sl.registerLazySingleton(
      () => AddFavoriteCityUseCase(travelRepository: sl()));
  sl.registerLazySingleton(
      () => DeleteFavoriteCityUseCase(travelRepository: sl()));

  // Repository
  sl.registerLazySingleton<TravelRepository>(() => TravelRepositoryImpl(
      travelRemoteDataSource: sl(),
      favoriteCityLocalDataSource: sl(),
      networkInfo: sl()));

  // Data Source
  sl.registerLazySingleton<TravelRemoteDataSource>(() =>
      SurahRemoteDataSourceImpl(networkManager: NetworkManagerImpl(sl())));

  sl.registerLazySingleton<FavoriteCityLocalDataSource>(
      () => FavoriteCityLocalDataSourceImpl(databaseHelper: DatabaseHelper()));

  sl.registerLazySingleton(() => NetworkInfo(Connectivity()));

  /**
   * ! External
   */
  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = "https://google.com";
    return dio;
  });
}
