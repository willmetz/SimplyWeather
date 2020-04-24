import 'dart:async';

import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class WeatherDatabase {
  static final WeatherDatabase _instance = WeatherDatabase._internal();
  static const String _DB_PATH = "Weather.db";
  Database _database;

  factory WeatherDatabase() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  WeatherDatabase._internal();

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await databaseFactoryIo.openDatabase(_DB_PATH);
    }

    return _database;
  }
}
