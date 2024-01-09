
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/model/travel_data_response.dart';
import '../repository/travel/travel_repository.dart';

class AddFavoriteCityUseCase implements UseCase<int, City> {
  final TravelRepository travelRepository;

  AddFavoriteCityUseCase({required this.travelRepository});

  @override
  Future<Either<Failure, int>> call(City city) async {
    return await travelRepository.insertCityToFavorite(city);
  }
}
