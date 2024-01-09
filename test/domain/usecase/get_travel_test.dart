import 'dart:convert';

import 'package:aspen_app/core/errors/failures.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:aspen_app/domain/repository/travel/travel_repository.dart';
import 'package:aspen_app/domain/usecase/get_travel_data.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixture/fixture_reader.dart';

class MockTravelRepository extends Mock implements TravelRepository {}

void main() {
  late GetTravelDataUseCase getTravelDataUseCase;
  late MockTravelRepository mockTravelRepository;
  setUp(() {
    mockTravelRepository = MockTravelRepository();
    getTravelDataUseCase =
        GetTravelDataUseCase(travelRepository: mockTravelRepository);
  });

  test("make sure getTravelData return success", () async {
    final responsePayload = json.decode(fixture('travel_response.json'));

    var travelResponse = TravelApiResponse.fromJson(responsePayload);

    when(() => mockTravelRepository.getTravelData())
        .thenAnswer((_) async => Right(travelResponse));

    var result = await getTravelDataUseCase
        .call(const ParamsGetTravelData(locationId: ""));
    expect(result, Right(travelResponse));
    verify(() => mockTravelRepository.getTravelData());
  });

  test("make sure getTravelData return failure", () async {
    when(() => mockTravelRepository.getTravelData()).thenAnswer((_) async => Left(ServerFailure("Unknown Error")));

    var result = await getTravelDataUseCase.call(const ParamsGetTravelData(locationId: ""));

    expect(result, Left(ServerFailure("Unknown Error")));
  });
}
