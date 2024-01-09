import 'package:aspen_app/core/local/DatabaseHelper.dart';
import 'package:aspen_app/data/datasource/travel/travel_local_data_source.dart';
import 'package:aspen_app/data/model/travel_data_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

void main() {
  late FavoriteCityLocalDataSourceImpl favoriteCityLocalDataSourceImpl;
  late MockDatabaseHelper mockDatabaseHelper;
  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    favoriteCityLocalDataSourceImpl =
        FavoriteCityLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group("Success", () {
    test("make sure insertCity return success", () async {
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      when(
        () => mockDatabaseHelper.insertData(city),
      ).thenAnswer((_) async => Future(() => 1));

      var result = await favoriteCityLocalDataSourceImpl.insertCity(city);
      expect(result, 1);
    });

    test("make sure getCityById return success", () async {
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      when(
        () => mockDatabaseHelper.queryDataById("1"),
      ).thenAnswer((_) async => Future(() => city));

      var result = await favoriteCityLocalDataSourceImpl.getCityById("1");
      expect(result, city);
    });

    test("make sure getAllFavoriteCities return success", () async {
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      when(
        () => mockDatabaseHelper.queryAllFavoriteCities(),
      ).thenAnswer((_) async => Future(() => [city]));

      var result = await favoriteCityLocalDataSourceImpl.getAllFavoriteCities();
      expect(result, [city]);
    });

    test("make sure deleteCity return success", () async {
      var city = City(id: 1, title: "Cairo", image: "image", rating: "5.0");
      when(
        () => mockDatabaseHelper.deleteData(city),
      ).thenAnswer((_) async => Future(() => 1));

      var result = await favoriteCityLocalDataSourceImpl.deleteCity(city);
      expect(result, 1);
    });
  });
}
