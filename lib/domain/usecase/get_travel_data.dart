import 'package:aspen_app/domain/repository/travel/travel_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/errors/failures.dart';
import '../../core/usecase/usecase.dart';
import '../../data/model/travel_data_response.dart';

class GetTravelDataUseCase
    implements UseCase<TravelApiResponse, ParamsGetTravelData> {
  final TravelRepository travelRepository;

  GetTravelDataUseCase({required this.travelRepository});

  @override
  Future<Either<Failure, TravelApiResponse>> call(
      ParamsGetTravelData params) async {
    return await travelRepository.getTravelData();
  }
}

class ParamsGetTravelData extends Equatable {
  final String locationId;

  const ParamsGetTravelData({required this.locationId});

  @override
  List<Object> get props => [locationId];

  @override
  String toString() {
    return 'ParamsGetTravelData{locationId: $locationId}';
  }
}
