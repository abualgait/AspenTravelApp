import 'package:aspen_app/domain/repository/travel/travel_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../core/errors/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../../../data/model/travel_data_response.dart';

class GetFavoriteCitiesUseCase implements UseCase<List<City>?, NoParams> {
  final TravelRepository travelRepository;

  GetFavoriteCitiesUseCase({required this.travelRepository});

  @override
  Future<Either<Failure, List<City>?>> call(NoParams params) async {
    return await travelRepository.getFavoriteCities();
  }
}
