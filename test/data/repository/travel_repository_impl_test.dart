import 'dart:convert';

import 'package:aspen_app/core/errors/failures.dart';
import 'package:aspen_app/core/network/network_info.dart';
import 'package:aspen_app/data/datasource/travel/travel_local_data_source.dart';
import 'package:aspen_app/data/datasource/travel/travel_remote_data_source.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:aspen_app/data/repository/travel/travel_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixture/fixture_reader.dart';

class MockTravelRemoteDataSource extends Mock
    implements TravelRemoteDataSource {}

class MockFavoriteCityLocalDataSource extends Mock
    implements FavoriteCityLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  //sut
  late TravelRepositoryImpl travelRepositoryImpl;
  late MockTravelRemoteDataSource mockTravelRemoteDataSource;
  late MockFavoriteCityLocalDataSource mockFavoriteCityLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockTravelRemoteDataSource = MockTravelRemoteDataSource();
    mockFavoriteCityLocalDataSource = MockFavoriteCityLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    travelRepositoryImpl = TravelRepositoryImpl(
        travelRemoteDataSource: mockTravelRemoteDataSource,
        favoriteCityLocalDataSource: mockFavoriteCityLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  test("make sure calling getTravelData - isConnected - return success",
      () async {
    when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    final responsePayload = json.decode(fixture('travel_response.json'));

    var travelResponse = TravelApiResponse.fromJson(responsePayload);

    when(() => mockTravelRemoteDataSource.getTravelData())
        .thenAnswer((_) => Future(() => travelResponse));

    var result = await travelRepositoryImpl.getTravelData();
    expect(result, Right(travelResponse));
  });

  test("make sure calling getTravelData - isConnected - return success",
      () async {
    when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

    when(() => mockTravelRemoteDataSource.getTravelData()).thenThrow(
        DioException(requestOptions: RequestOptions(), error: "Unknown Error"));

    var result = await travelRepositoryImpl.getTravelData();
    expect(result, Left(ServerFailure("Unknown Error")));
  });

  group("Offline Datasource", () {
    test(
        "make sure calling getAllFavoriteCities  - return success",
        () async {
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      List<City>? cities = [city];
      when(() => mockFavoriteCityLocalDataSource.getAllFavoriteCities())
          .thenAnswer((_) => Future(() => cities));

      var result = await travelRepositoryImpl.getFavoriteCities();
      expect(result, Right(cities));
    });

    test("make sure calling insertCityToFavorite - return success",
        () async {
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

      City? city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");

      when(() =>
              mockFavoriteCityLocalDataSource.insertCity(city))
          .thenAnswer((_) => Future(() => 1));

      var result = await travelRepositoryImpl.insertCityToFavorite(city);
      expect(result, Right(city.id));
    });


    test("make sure calling deleteCity - return success",
        () async {
      when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);

      City? city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");

      when(() =>
              mockFavoriteCityLocalDataSource.deleteCity(city))
          .thenAnswer((_) => Future(() => 1));

      var result = await travelRepositoryImpl.removeCityFromFavorite(city);
      expect(result, Right(city.id));
    });
  });
}
