import 'package:aspen_app/domain/repository/travel/travel_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/model/travel_data_response.dart';

class DeleteFavoriteCityUseCase implements UseCase<int, City> {
  final TravelRepository travelRepository;

  DeleteFavoriteCityUseCase({required this.travelRepository});

  @override
  Future<Either<Failure, int>> call(City city) async {
    return await travelRepository.removeCityFromFavorite(city);
  }
}
