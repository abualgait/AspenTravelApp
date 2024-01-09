import 'package:aspen_app/core/local/DatabaseHelper.dart';

import '../../model/travel_data_response.dart';

abstract class FavoriteCityLocalDataSource {
  Future<City?> getCityById(String cityId);
  Future<List<City>?> getAllFavoriteCities();
  Future<int> insertCity(City city);
  Future<int> deleteCity(City city);
}

class FavoriteCityLocalDataSourceImpl implements FavoriteCityLocalDataSource {
  final DatabaseHelper databaseHelper;

  FavoriteCityLocalDataSourceImpl({
    required this.databaseHelper,
  });

  @override
  Future<City?> getCityById(String cityId) {
    return databaseHelper.queryDataById(cityId);
  }

  @override
  Future<int> insertCity(City city) {
    return databaseHelper.insertData(city);
  }

  @override
  Future<List<City>?> getAllFavoriteCities() {
    return databaseHelper.queryAllFavoriteCities();
  }

  @override
  Future<int> deleteCity(City city) {
    return databaseHelper.deleteData(city);
  }
}
