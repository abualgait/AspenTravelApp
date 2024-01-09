import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/model/travel_data_response.dart';

abstract class IDatabase {
  Future<int> insertData(City data);

  Future<int> deleteData(City data);

  Future<City?> queryDataById(String cityId);

  Future<List<City>?> queryAllFavoriteCities();
}

class DatabaseHelper extends IDatabase {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    // Initialize and open the database.
    final path = join(await getDatabasesPath(), 'aspen_database.db');
    return openDatabase(path, version: 2, onCreate: _createTable);
  }

  static void _createTable(Database db, int version) async {
    await db.execute('''
      CREATE TABLE city (
        id INTEGER PRIMARY KEY,
        title TEXT,
        rating TEXT,
        image TEXT
      )
    ''');
  }

  @override
  Future<int> insertData(City data) async {
    var response = await _database!.insert('city', data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return response;
  }

  @override
  Future<int> deleteData(City data) async {
    return await _database!
        .delete('city', where: 'id = ?', whereArgs: [data.id]);
  }

  @override
  Future<City?> queryDataById(String cityId) async {
    var result = await _database!.query(
      'city',
      where: 'id = ?',
      whereArgs: [cityId],
    );
    if (result.isNotEmpty) {
      return City.fromJson(result.first);
    } else {
      return null;
    }
  }

  @override
  Future<List<City>?> queryAllFavoriteCities() async {
    var result = await _database!.rawQuery('SELECT * FROM city');
    if (result.isNotEmpty) {
      List<City> cityList = result.map((json) => City.fromJson(json)).toList();

      return cityList;
    } else {
      return null;
    }
  }
}
