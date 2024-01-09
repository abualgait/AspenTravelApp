import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../data/model/travel_data_response.dart';

abstract class TravelRepository {
  Future<Either<Failure, TravelApiResponse>> getTravelData();
  Future<Either<Failure, List<City>?>> getFavoriteCities();
  Future<Either<Failure, int>> insertCityToFavorite(City city);
  Future<Either<Failure, int>> removeCityFromFavorite(City city);
}
