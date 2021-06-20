import 'package:delivery/Database/DatabaseHelper.dart';
import 'package:delivery/Database/ModelToDB.dart';
import 'package:dio/dio.dart';

import 'AllUrl.dart';

class Product {
  final int id;
  final String productName;
  final String hsnCode;
  final String basePrice;
  final String stokistPrice;
  final String distributorPrice;
  final String retailerPrice;
  final String description;
  final String image;
  final String cmpyid;
  final List<Sku> sku;
  Product({
    this.id,
    this.productName,
    this.hsnCode,
    this.basePrice,
    this.stokistPrice,
    this.distributorPrice,
    this.retailerPrice,
    this.description,
    this.image,
    this.cmpyid,
    this.sku,
  });
}

class Sku {
  final int skuid;
  final String name;
  Sku({
    this.skuid,
    this.name,
  });
}

Future<List<Product>> getProduct() async {
  List<Product> product = [];
  Dio dio = Dio();
  dynamic response = await dio.get(api + "products/get");
  if (response.statusCode == 200) {
    dynamic data = response.data;
    for (dynamic res in data) {
      List<Sku> sku = [];
      for (dynamic s in res['category']) {
        Sku sData = Sku(
          skuid: s['sku']['id'],
          name: s['sku']['category_name'],
        );
        sku.add(sData);
      }
      Product prod = Product(
        id: res['id'],
        productName: res['product_name'],
        hsnCode: res['product_hsncode'],
        basePrice: res['product_baseprice'],
        stokistPrice: res['product_stokistprice'],
        distributorPrice: res['product_distributorprice'],
        retailerPrice: res['product_retailerprice'],
        description: res['product_description'],
        image: res['product_image'],
        cmpyid: res['product_companyid'],
        sku: sku,
      );
      product.add(prod);
    }
  }
  return product;
}

class Cart {
  final int productId;
  final String productName;
  int quantity;
  final String yourPrice;
  Cart({
    this.productId,
    this.productName,
    this.yourPrice,
    this.quantity,
  });
}

createCartTable() {
  List<Table> column = [];
  Table productId = Table(
    columnName: "productid",
    columnType: "int",
    isNull: "NULL",
  );
  column.add(productId);
  Table productName = Table(
    columnName: "productname",
    columnType: "String",
    isNull: "NULL",
  );
  column.add(productName);
  Table yourPrice = Table(
    columnName: "yourprice",
    columnType: "String",
    isNull: "NULL",
  );
  column.add(yourPrice);
  Table quantity = Table(
    columnName: "quantity",
    columnType: "String",
    isNull: "NULL",
  );
  column.add(quantity);
  DatabaseHelper.instance.createTable("tblcart", column);
}

addToCart(Cart prod) async {
  createCartTable();
  List<Map<String, dynamic>> check = await DatabaseHelper.instance
      .queryTableData(
          table: "tblcart", key: "productid", value: prod.productId);
  print(check.length);
  if (check.length > 0) {
    Map<String, dynamic> row = {
      "productid": prod.productId,
      "productname": prod.productName,
      "yourprice": prod.yourPrice,
      "quantity": prod.quantity,
    };
    DatabaseHelper.instance.insertTable(row, "tblcart");
  } else {
    Map<String, dynamic> row = {
      "productid": prod.productId,
      "productname": prod.productName,
      "yourprice": prod.yourPrice,
      "quantity": prod.quantity,
    };
    DatabaseHelper.instance
        .updateTableData(row, "productid", prod.productId, "tblcart");
  }
}
