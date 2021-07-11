import 'ModelToDB.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _dbName = 'demodb';
  static final _dbVersion = 1;

  //cart

  static final tblCart = 'tbl_cart';
  static final cartId = 'cart_id';
  static final cartProductId = 'cart_productid';
  static final cartProductName = 'cart_productname';
  static final cartProductPrice = 'cart_productprice';
  static final cartProductCount = 'cart_productcount';
  static final cartProductImage = 'cart_productimage';
  static final cartProductTax = 'cart_productTax';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {}

  Future<int> insertCart(Map<String, dynamic> row) async {
    try {
      Database db = await instance.database;
      return await db.insert(tblCart, row);
    } catch (e) {
      print('error===>');
      return 1;
    }
  }

  // Future<List<CartProduct>> queryCart() async {
  //   Database db = await instance.database;
  //   List<CartProduct> sendData = [];
  //   dynamic data = await db.query("$tblCart");
  //   print(data.length);
  //   for (dynamic res in data) {
  //     // print("productName:"+res['name'])
  //     CartProduct prod = CartProduct(
  //       productId: res[cartProductId],
  //       name: res[cartProductName],
  //       price: res[cartProductPrice].toString(),
  //       image: (res[cartProductPrice] != null)
  //           ? res[cartProductImage]
  //           : "dummy.png",
  //       count: res[cartProductCount],
  //     );
  //     sendData.add(prod);
  //   }
  //   return sendData;
  // }

  truncateCart() async {
    Database db = await instance.database;
    await db.execute("DELETE FROM $tblCart");
  }

  Future updateCart(Map<String, dynamic> row, int cartid) async {
    Database db = await instance.database;
    int id = cartid;
    return await db.update(tblCart, row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteCart(int id) async {
    Database db = await instance.database;
    return await db.delete(tblCart, where: "$cartProductId=?", whereArgs: [id]);
  }

  Future<bool> createTable(String tablename, List<Table> column) async {
    bool response = false;
    try {
      Database db = await instance.database;

      String columnData = '';
      columnData += tablename + "_id" + "  INTEGER PRIMARY KEY autoincrement,";
      for (dynamic res in column) {
        columnData +=
            res.columnName + " " + res.columnType + " " + res.isNull + ",";
      }
      if (columnData != null && columnData.length > 0) {
        columnData = columnData.substring(0, columnData.length - 1);
      }
      await db.execute(
          'CREATE TABLE if not exists $tablename ( ' + columnData + ' )');
      response = true;
    } catch (e) {
      print(e);
    }
    return response;
  }

  Future<int> deleteTableData(int id, String key, String table) async {
    Database db = await instance.database;
    return await db.delete(table, where: "$key=?", whereArgs: [id]);
  }

  Future<int> deleteTableMultiData(
      List<String> keys, List<dynamic> value, String table) async {
    Database db = await instance.database;
    String key = " ";
    for (String i in keys) {
      key += i + " = ? and ";
    }
    key = key.substring(0, key.length - 4);
    return await db.delete(table, where: key, whereArgs: value);
  }

  Future updateTableData(
      Map<String, dynamic> row, String key, int id, String table) async {
    Database db = await instance.database;

    return await db.update(table, row, where: '$key = ?', whereArgs: [id]);
  }

  Future updateTableMultiData(Map<String, dynamic> row, List<String> keys,
      List<dynamic> value, String table) async {
    Database db = await instance.database;
    String key = " ";
    for (String i in keys) {
      key += i + " = ? and ";
    }
    key = key.substring(0, key.length - 4);
    return await db.update(table, row, where: key, whereArgs: value);
  }

  truncateTable(String table) async {
    Database db = await instance.database;
    await db.execute("DELETE FROM $table");
  }

  Future<List<Map<String, dynamic>>> queryAllTableData({String table}) async {
    Database db = await instance.database;
    return await db.query("$table");
  }

  Future<List<Map<String, dynamic>>> queryTableData(
      {String table, String key, dynamic value}) async {
    Database db = await instance.database;
    return await db.query("$table", where: "$key= ?", whereArgs: [value]);
  }

  Future<List<Map<String, dynamic>>> queryTableMultiData(
      {String table, List<String> keys, List<dynamic> value}) async {
    Database db = await instance.database;
    String key = " ";
    for (String i in keys) {
      key += i + " = ? and ";
    }
    key = key.substring(0, key.length - 4);
    return await db.query("$table", where: key, whereArgs: value);
  }

  Future<int> insertTable(Map<String, dynamic> row, table) async {
    Database db = await instance.database;
    return await db.insert("$table", row);
  }
}
