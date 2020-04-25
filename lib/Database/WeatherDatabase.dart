import 'dart:async';

import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class WeatherDatabase {
  static final WeatherDatabase _instance = WeatherDatabase._internal();
  static const String _DB_NAME = "Weather.db";
  Database _database;

  factory WeatherDatabase() {
    return _instance;
  }

  //private constructor to ensure this class is only created here
  WeatherDatabase._internal();

  Future<Database> getDatabase() async {
    if (_database == null) {
      final appDir = await getApplicationDocumentsDirectory();
      _database = await databaseFactoryIo.openDatabase(appDir.path + _DB_NAME);
    }

    return _database;
  }
}
