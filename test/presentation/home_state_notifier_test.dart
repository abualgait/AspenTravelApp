import 'dart:convert';

import 'package:aspen_app/core/errors/failures.dart';
import 'package:aspen_app/core/usecase/usecase.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:aspen_app/domain/usecase/get_favorite_data.dart';
import 'package:aspen_app/domain/usecase/get_travel_data.dart';
import 'package:aspen_app/domain/usecase/insert_favorite_city.dart';
import 'package:aspen_app/domain/usecase/remove_favorite_city.dart';
import 'package:aspen_app/presentation/home_screen/provider/home_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../fixture/fixture_reader.dart';

class MockGetTravelDataUseCase extends Mock implements GetTravelDataUseCase {}

class MockGetFavoriteCitiesUseCase extends Mock
    implements GetFavoriteCitiesUseCase {}

class MockAddFavoriteCityUseCase extends Mock
    implements AddFavoriteCityUseCase {}

class MockDeleteFavoriteCityUseCase extends Mock
    implements DeleteFavoriteCityUseCase {}

void main() {
  late MockGetTravelDataUseCase mockGetTravelDataUseCase;
  late MockGetFavoriteCitiesUseCase mockGetFavoriteCitiesUseCase;
  late MockAddFavoriteCityUseCase mockAddFavoriteCityUseCase;
  late MockDeleteFavoriteCityUseCase mockDeleteFavoriteCityUseCase;
  late HomeStateNotifier homeStateNotifier;

  setUp(() {
    mockGetTravelDataUseCase = MockGetTravelDataUseCase();
    mockGetFavoriteCitiesUseCase = MockGetFavoriteCitiesUseCase();
    mockAddFavoriteCityUseCase = MockAddFavoriteCityUseCase();
    mockDeleteFavoriteCityUseCase = MockDeleteFavoriteCityUseCase();

    homeStateNotifier = HomeStateNotifier(
        getFavoriteCitiesUseCase: mockGetFavoriteCitiesUseCase,
        getTravelDataUseCase: mockGetTravelDataUseCase,
        addFavoriteCityUseCase: mockAddFavoriteCityUseCase,
        deleteFavoriteCityUseCase: mockDeleteFavoriteCityUseCase);
  });

  tearDown(() => homeStateNotifier.dispose());

  group('GetTravelData Tests', () {
    test('getTravelData success should update UI states', () async {
      final responsePayload = json.decode(fixture('travel_response.json'));

      var travelResponse = TravelApiResponse.fromJson(responsePayload);
      when(() => mockGetTravelDataUseCase
              .call(const ParamsGetTravelData(locationId: "")))
          .thenAnswer((_) async => Right(travelResponse));

      // Act
      homeStateNotifier.loadTravelData();

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.popular.length, 3);
      expect(homeStateNotifier.state.recommended.length, 3);
      expect(homeStateNotifier.state.categories.length, 8);
      expect(homeStateNotifier.state.error, '');
    });

    test('getTravelData ServerFailure should update UI states', () async {
      when(() => mockGetTravelDataUseCase
              .call(const ParamsGetTravelData(locationId: "")))
          .thenAnswer((_) async => Left(ServerFailure("error")));

      // Act
      homeStateNotifier.loadTravelData();

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.popular.length, 0);
      expect(homeStateNotifier.state.recommended.length, 0);
      expect(homeStateNotifier.state.categories.length, 0);
      expect(homeStateNotifier.state.error, 'error');
    });

    test('getTravelData ConnectionFailure  should update UI states', () async {
      when(() => mockGetTravelDataUseCase
              .call(const ParamsGetTravelData(locationId: "")))
          .thenAnswer((_) async => Left(ConnectionFailure()));

      // Act
      homeStateNotifier.loadTravelData();

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.popular.length, 0);
      expect(homeStateNotifier.state.recommended.length, 0);
      expect(homeStateNotifier.state.categories.length, 0);
      expect(homeStateNotifier.state.error, messageConnectionFailure);
    });
  });

  group('LoadFavoriteCities Tests', () {
    test('loadFavoriteCities success should update UI states', () async {
      //Arrange
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      List<City>? cities = [city];

      when(() => mockGetFavoriteCitiesUseCase.call(NoParams()))
          .thenAnswer((_) async => Right(cities));

      // Act
      homeStateNotifier.loadFavoriteCities();

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.isFavLoading, false);
      expect(homeStateNotifier.state.favoriteCitiesList.length, 1);
      expect(homeStateNotifier.state.favoriteCitiesList[0], city);
      expect(homeStateNotifier.state.error, '');
    });

    test('loadFavoriteCities ServerFailure should update UI states', () async {
      //Arrange
      when(() => mockGetFavoriteCitiesUseCase.call(NoParams()))
          .thenAnswer((_) async => Left(DatabaseFailure()));

      // Act
      homeStateNotifier.loadFavoriteCities();

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.favoriteCitiesList.length, 0);
      expect(homeStateNotifier.state.error, messageDataBaseFailure);
    });
  });

  group('DeleteFavoriteCity Tests', () {
    test('deleteFavoriteCity success should update UI states', () async {
      //Arrange
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      List<City>? cities = [city];

      when(() => mockDeleteFavoriteCityUseCase.call(city))
          .thenAnswer((_) async => Right(city.id));

      when(() => mockGetFavoriteCitiesUseCase.call(NoParams()))
          .thenAnswer((_) async => const Right([]));
      // Act
      homeStateNotifier.removeCityFromFavorite(city);

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.isFavLoading, false);
      expect(homeStateNotifier.state.favoriteCitiesList.length, 0);
      expect(homeStateNotifier.state.error, '');
    });
  });

  group('AddFavoriteCity Tests', () {
    test('addFavoriteCity success should update UI states', () async {
      //Arrange
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      List<City>? cities = [city];

      when(() => mockAddFavoriteCityUseCase.call(city))
          .thenAnswer((_) async => Right(city.id));

      when(() => mockGetFavoriteCitiesUseCase.call(NoParams()))
          .thenAnswer((_) async => Right(cities));
      // Act
      homeStateNotifier.addCityToFavorite(city);

      // Allow time for the asynchronous operation to complete
      await Future.delayed(Duration.zero);

      // Assert
      expect(homeStateNotifier.state.isLoading, false);
      expect(homeStateNotifier.state.isFavLoading, false);
      expect(homeStateNotifier.state.favoriteCitiesList.length, 1);
      expect(homeStateNotifier.state.error, '');
    });
  });
}
