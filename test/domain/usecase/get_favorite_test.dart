import 'package:aspen_app/core/errors/failures.dart';
import 'package:aspen_app/core/usecase/usecase.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:aspen_app/domain/repository/travel/travel_repository.dart';
import 'package:aspen_app/domain/usecase/get_favorite_data.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTravelRepository extends Mock implements TravelRepository {}

void main() {
  late GetFavoriteCitiesUseCase getFavoriteCitiesUseCase;
  late MockTravelRepository mockTravelRepository;
  setUp(() {
    mockTravelRepository = MockTravelRepository();
    getFavoriteCitiesUseCase =
        GetFavoriteCitiesUseCase(travelRepository: mockTravelRepository);
  });

  test("make sure getFavoriteCitiesUseCase return success", () async {
    var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
    List<City>? cities = [city];
    when(() => mockTravelRepository.getFavoriteCities())
        .thenAnswer((_) async => Right(cities));

    var result = await getFavoriteCitiesUseCase.call(NoParams());
    expect(result, Right(cities));
    verify(() => mockTravelRepository.getFavoriteCities());
  });

  test("make sure getFavoriteCitiesUseCase return failure", () async {
    when(() => mockTravelRepository.getFavoriteCities())
        .thenAnswer((_) async => Left(DatabaseFailure()));

    var result = await getFavoriteCitiesUseCase.call(NoParams());
    expect(result, Left(DatabaseFailure()));
    verify(() => mockTravelRepository.getFavoriteCities());
  });
}
