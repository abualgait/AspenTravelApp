import 'dart:convert';

import 'package:aspen_app/core/errors/failures.dart';
import 'package:aspen_app/core/usecase/usecase.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:aspen_app/domain/repository/travel/travel_repository.dart';
import 'package:aspen_app/domain/usecase/get_travel_data.dart';
import 'package:aspen_app/domain/usecase/insert_favorite_city.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixture/fixture_reader.dart';

class MockTravelRepository extends Mock implements TravelRepository {}

void main() {
  late AddFavoriteCityUseCase addFavoriteCityUseCase;
  late MockTravelRepository mockTravelRepository;
  setUp(() {
    mockTravelRepository = MockTravelRepository();
    addFavoriteCityUseCase =
        AddFavoriteCityUseCase(travelRepository: mockTravelRepository);
  });

  test("make sure insertCityToFavorite return success", () async {
    var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
    when(() => mockTravelRepository.insertCityToFavorite(city))
        .thenAnswer((_) async => Right(city.id));

    var result = await addFavoriteCityUseCase
        .call(city);
    expect(result, Right(city.id));
    verify(() => mockTravelRepository.insertCityToFavorite(city));
  });

  test("make sure insertCityToFavorite return failure", () async {
    var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
    when(() => mockTravelRepository.insertCityToFavorite(city)).thenAnswer((_) async => Left(DatabaseFailure()));

    var result = await addFavoriteCityUseCase.call(city);

    expect(result, Left(DatabaseFailure()));
  });
}
