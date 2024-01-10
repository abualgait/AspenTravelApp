import 'package:aspen_app/data/datasource/travel/travel_local_data_source.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../core/errors/failures.dart';
import '../../../core/network/network_info.dart';
import '../../../domain/repository/travel/travel_repository.dart';
import '../../datasource/travel/travel_remote_data_source.dart';
import '../../model/travel_data_response.dart';

class TravelRepositoryImpl implements TravelRepository {
  final TravelRemoteDataSource travelRemoteDataSource;
  final FavoriteCityLocalDataSource favoriteCityLocalDataSource;
  final NetworkInfo networkInfo;

  TravelRepositoryImpl({
    required this.travelRemoteDataSource,
    required this.favoriteCityLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TravelApiResponse>> getTravelData() async {
    bool isConnected = await networkInfo.isConnected();
    if (isConnected) {
      try {
        var response = await travelRemoteDataSource.getTravelData();
        return Right(response);
      } on DioException catch (error) {
        return Left(ServerFailure(error.message ?? "Unknown Error"));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<City>?>> getFavoriteCities() async {
    try {
      var response = await favoriteCityLocalDataSource.getAllFavoriteCities();
      return Right(response);
    } on Exception catch (error) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> insertCityToFavorite(City city) async {
    try {
      var response = await favoriteCityLocalDataSource.insertCity(city);
      if (response != city.id) {
        return Left(DatabaseFailure());
      }
      return Right(response);
    } on Exception catch (error) {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, int>> removeCityFromFavorite(City city) async {
    try {
      var response = await favoriteCityLocalDataSource.deleteCity(city);
      if (response != city.id) {
        return Left(DatabaseFailure());
      }
      return Right(response);
    } on Exception catch (error) {
      return Left(DatabaseFailure());
    }
  }
}
