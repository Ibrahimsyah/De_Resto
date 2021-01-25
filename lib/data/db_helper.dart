import 'package:de_resto/data/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database _database;
  static DatabaseHelper _deRestoDb;
  static String _tableRestaurants = 'restaurants';

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_deRestoDb == null) {
      _deRestoDb = DatabaseHelper._createObject();
    }
    return _deRestoDb;
  }
  Future<Database> get database async {
    _database = await initializeDb();
    return _database;
  }

  Future<Database> initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/de_resto.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableRestaurants (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating TEXT
           )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final Database db = await database;
    await db.insert(_tableRestaurants, restaurant.toJson());
  }

  Future<Restaurant> getRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results =
        await db.query(_tableRestaurants, where: 'id = ?', whereArgs: [id]);
    var restaurants =
        results.map((restaurant) => Restaurant.fromJson(restaurant));
    return restaurants.length > 0 ? restaurants.first : null;
  }

  Future<List<Restaurant>> getAllRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableRestaurants);
    return results
        .map((restaurant) => Restaurant.fromJson(restaurant))
        .toList();
  }

  Future<void> deleteRestaurant(String id) async {
    final Database db = await database;
    await db.delete(_tableRestaurants, where: 'id = ?', whereArgs: [id]);
  }
}
