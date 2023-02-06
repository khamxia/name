
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../store_database/sqlite_store_model.dart';

class SQLiteOneOoderHelper {
  final String databaseNames = 'store.db';
  final String tableName = 'storeTABLE';
  int version = 1;

  final String id = 'id';
  final String productID = 'productID';
  final String productName = 'productName';
  final String amount = 'amount';
  final String category = 'category';
  final String price = 'price';
  final String total = 'total';
  final String branchID = 'branchID';
  final String branchName = 'branchName';

  SQLiteOneOoderHelper() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    // 1. Open/Create Database
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseNames);
    await openDatabase(path, version: version,
        onCreate: (Database database, int version) async {
      await database.execute(
          'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $productID TEXT, $productName TEXT, $amount TEXT, $category TEXT, $price TEXT, $total TEXT, $branchID TEXT, $branchName TEXT)');
    });
  }

  Future<Database> connectDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, databaseNames);
    return openDatabase(path);
  }

  Future<void> insertData(SqliteStoreModel sqliteStoreModel) async {
    Database db = await connectDatabase();
    try {
      db.insert(tableName, sqliteStoreModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('e = $e');
    }
  }

  Future<List<SqliteStoreModel>> readData() async {
    Database db = await connectDatabase();
    try {
      List<SqliteStoreModel> sqliteStoreModelslist = [];
      List<Map<String, dynamic>> maps = await db.query(tableName);
      for (var map in maps) {
        SqliteStoreModel sqliteStoreModel = SqliteStoreModel.fromJson(map);
        sqliteStoreModelslist.add(sqliteStoreModel);
      }
      return sqliteStoreModelslist;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteStoreData(int id) async {
    Database db = await connectDatabase();
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('delete error = $e');
    }
  }

  Future<void> deleteAllData() async {
    Database db = await connectDatabase();
    try {
      await db.delete(tableName);
      
    } catch (e) {
      print('delete all error = $e');
    }
  }

  Future<void> updateData(SqliteStoreModel sqliteStoreModel) async {
    Database db = await connectDatabase();
    try {
      await db.update(tableName, sqliteStoreModel.toJson(),
          where: 'id = ?', whereArgs: [sqliteStoreModel.id]);
    } catch (e) {
      print('update error = $e');
    }
  }

  Future<int?> getCount() async {
    Database db = await connectDatabase();
    try {
      return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $tableName'));
    } catch (e) {
      return 0;
    }
  }

  Future<void> closeDatabase() async {
    Database db = await connectDatabase();
    try {
      await db.close();
    } catch (e) {
      print('close error = $e');
    }
  }

  Future<void> updateAmountAndTotal(
      String prId, String amounts, String totals) async {
    Database db = await connectDatabase();
    try {
      await db.rawUpdate(
          'UPDATE storeTABLE SET amount = ?, total= ? WHERE $productID = ?',
          [amounts, totals, prId]);
    } catch (e) {
      print('errr update ${e.toString()}');
    }
  }

  Future<List<SqliteStoreModel>> readDataSingle(int pId) async {
    Database db = await connectDatabase();
    List<SqliteStoreModel> sqLiteModelslist = [];
    List<Map<String, dynamic>> maps =
        await db.query(tableName, where: 'productID = ?', whereArgs: [pId]);
    for (var map in maps) {
      SqliteStoreModel sqLiteModel = SqliteStoreModel.fromJson(map);
      sqLiteModelslist.add(sqLiteModel);
    }
    return sqLiteModelslist;
  }
}
