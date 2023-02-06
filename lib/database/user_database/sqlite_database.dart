import 'package:meesooklife_app/database/user_database/sqlite_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteHelper {
  final String databaseName = 'meesooklife.db';
  final String tableName = 'orderTABLE';
  int version = 1;

  final String id = 'id';
  final String productId = 'productId';
  final String productName = 'productName';
  final String amount = 'amount';
  final String category = 'category';
  final String price = 'price';
  final String total = 'total';
  final String branchId = 'branchId';
  final String branchName = 'branchName';

  SQLiteHelper() {
    initDatabase();
  }
  Future<void> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), databaseName),
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $productId TEXT, $productName TEXT, $amount TEXT, $category TEXT, $price TEXT, $total TEXT, $branchId TEXT, $branchName TEXT)');
    }, version: version);
  }

  Future<Database> connectDatabase() async {
    return openDatabase(join(await getDatabasesPath(), databaseName));
  }

  Future<void> insertData(SQLiteModel sqLiteModel) async {
    Database db = await connectDatabase();
    try {
      db.insert(tableName, sqLiteModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {}
  }

  Future<List<SQLiteModel>> readData() async {
    Database db = await connectDatabase();
    try {
      List<SQLiteModel> sqLiteModelslist = [];
      List<Map<String, dynamic>> maps = await db.query(tableName);
      for (var map in maps) {
        SQLiteModel sqLiteModel = SQLiteModel.fromJson(map);
        sqLiteModelslist.add(sqLiteModel);
      }
      return sqLiteModelslist;
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteData(int id) async {
    Database db = await connectDatabase();
    try {
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('errr delete ${e.toString()}');
    }
  }

  Future<void> deleteAllData() async {
    Database db = await connectDatabase();
    try {
      await db.delete(tableName);
    } catch (e) {
      print('errr delete all ${e.toString()}');
    }
  }

  Future<void> updateData(SQLiteModel sqLiteModel) async {
    Database db = await connectDatabase();
    try {
      await db.update(tableName, sqLiteModel.toJson(),
          where: 'id = ?', whereArgs: [sqLiteModel.id]);
    } catch (e) {
      print('errr update ${e.toString()}');
    }
  }

  Future<void> updateAmount(int id, int amount) async {
    Database db = await connectDatabase();
    try {
      await db.rawUpdate(
          'UPDATE $tableName SET $amount = ? WHERE $id = ?', [amount, id]);
    } catch (e) {
      print('errr update ${e.toString()}');
    }
  }

  Future<void> updateTotal(int id, int total) async {
    Database db = await connectDatabase();
    try {
      await db.rawUpdate(
          'UPDATE $tableName SET $total = ? WHERE $id = ?', [total, id]);
    } catch (e) {
      print('errr update ${e.toString()}');
    }
  }

  Future<void> updateAmountAndTotal(
      String prId, String amounts, String totals) async {
    Database db = await connectDatabase();
    try {
      await db.rawUpdate(
          'UPDATE orderTABLE SET amount = ?, total= ? WHERE $productId = ?',
          [amounts, totals, prId]);
    } catch (e) {
      print('errr update ${e.toString()}');
    }
  }

  Future<List<SQLiteModel>> readDataSingle(int pId) async {
    Database db = await connectDatabase();
    List<SQLiteModel> sqLiteModelslist = [];
    List<Map<String, dynamic>> maps =
        await db.query(tableName, where: 'productId = ?', whereArgs: [pId]);
    for (var map in maps) {
      SQLiteModel sqLiteModel = SQLiteModel.fromJson(map);
      sqLiteModelslist.add(sqLiteModel);
    }
    return sqLiteModelslist;
  }
}
