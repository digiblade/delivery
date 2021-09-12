import 'package:delivery/Database/DatabaseHelper.dart';
import 'package:delivery/Database/ModelToDB.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AllUrl.dart';

class Product {
  int index;
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
    this.index,
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
  SharedPreferences pref = await SharedPreferences.getInstance();
  String id = pref.getString('id');
  dynamic response = await dio.get("${api}company/products/$id");
  if (response.statusCode == 200) {
    print(response);
    dynamic data = response.data;
    int count = 1;
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
        index: count,
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
      count++;
    }
  }
  return product;
}

Future<List<Product>> getProductById() async {
  List<Product> product = [];
  try {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString('id');
    print(id);
    FormData form = FormData.fromMap({
      "id": id,
    });
    dynamic response = await dio.post(
      "${api}getStock",
      data: form,
    );
    if (response.statusCode == 200) {
      dynamic data = response.data;

      int count = 1;
      for (dynamic res in data) {
        List<Sku> sku = [];

        Sku sData = Sku(
          skuid: res['sku']['id'],
          name: res['sku']['category_name'],
        );
        sku.add(sData);

        Product prod = Product(
          index: count,
          id: res['product']['id'],
          productName: res['product']['product_name'],
          hsnCode: res['product']['product_hsncode'],
          basePrice: res['product']['product_baseprice'],
          stokistPrice: res['product']['product_stokistprice'],
          distributorPrice: res['product']['product_distributorprice'],
          retailerPrice: res['product']['product_retailerprice'],
          description: res['product']['product_description'],
          image: res['product']['product_image'],
          cmpyid: res['product']['product_companyid'],
          sku: sku,
        );
        product.add(prod);
        count++;
      }
    }
  } catch (e) {
    print(e);
  }
  return product;
}

class SKU {
  final int index;
  final int skuid;
  final String skuname;
  final String skuimage;
  SKU({
    this.index,
    this.skuid,
    this.skuname,
    this.skuimage,
  });
}

Future<List<SKU>> getSKU() async {
  List<SKU> product = [];
  Dio dio = Dio();

  dynamic response = await dio.get("${api}company/category");
  if (response.statusCode == 200) {
    dynamic data = response.data;
    int count = 1;
    for (dynamic res in data) {
      SKU sData = SKU(
        index: count++,
        skuid: res['id'],
        skuimage: res['category_image'],
        skuname: res['category_name'],
      );

      product.add(sData);
    }
  }

  return product;
}

class Manufacturing {
  final int index;
  final int id;
  final String code;
  final String bprice;
  final String ssprice;
  final String dprice;
  final String rprice;
  final String total;
  final String sold;
  final String skuname;
  final String productname;
  Manufacturing({
    this.rprice,
    this.total,
    this.sold,
    this.index,
    this.id,
    this.code,
    this.bprice,
    this.ssprice,
    this.dprice,
    this.skuname,
    this.productname,
  });
}

Future<List<Manufacturing>> getManu(id) async {
  List<Manufacturing> product = [];
  Dio dio = Dio();

  dynamic response = await dio.get("${api}company/manufacturing/$id");
  if (response.statusCode == 200) {
    dynamic data = response.data;
    int count = 1;
    for (dynamic res in data['manufacturing']) {
      Manufacturing sData = Manufacturing(
        index: count++,
        id: int.parse(res['manufacturing_id']),
        code: res['manufacturing_code'],
        bprice: res['manufacturing_baseprice'],
        dprice: res['manufacturing_distibutorprice'],
        ssprice: res['manufacturing_stokistprice'],
        rprice: res['manufacturing_retailerprice'],
        total: res['manufacturing_totalcount'],
        sold: res['manufacturing_sold'],
        skuname: res['sku']['category_name'],
        productname: res['product']['product_name'],
      );

      product.add(sData);
    }
  }

  return product;
}

class Cart {
  final int productId;
  final String productName;
  final String productImage;
  int quantity;
  final String yourPrice;
  final String sku;
  final int skuid;
  final String price;
  final int tableid;
  Cart(
      {this.productId,
      this.productName,
      this.yourPrice,
      this.quantity,
      this.productImage,
      this.sku,
      this.skuid,
      this.price,
      this.tableid});
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
  Table price = Table(
    columnName: "price",
    columnType: "String",
    isNull: "NULL",
  );
  column.add(price);
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
  Table image = Table(
    columnName: "image",
    columnType: "String",
    isNull: "NULL",
  );
  column.add(image);
  Table sku = Table(
    columnName: "sku",
    columnType: "String",
    isNull: "NULL",
  );
  column.add(sku);
  Table skuid = Table(
    columnName: "skuid",
    columnType: "int",
    isNull: "NULL",
  );
  column.add(skuid);
  DatabaseHelper.instance.createTable("tblcart", column);
}

addToCart(Cart prod) async {
  await createCartTable();

  List<Map<String, dynamic>> check = await DatabaseHelper.instance
      .queryTableMultiData(
          table: "tblcart",
          keys: ["productid", "skuid"],
          value: [prod.productId, prod.skuid]);
  print(check.length);
  if (check.length == 0) {
    Map<String, dynamic> row = {
      "productid": prod.productId,
      "productname": prod.productName,
      "yourprice": prod.yourPrice,
      "quantity": prod.quantity,
      "image": prod.productImage,
      "price": prod.price,
      "sku": prod.sku,
      "skuid": prod.skuid,
    };
    DatabaseHelper.instance.insertTable(row, "tblcart");
  } else {
    Map<String, dynamic> row = {
      "productid": prod.productId,
      "productname": prod.productName,
      "yourprice": prod.yourPrice,
      "quantity": prod.quantity,
      "image": prod.productImage,
      "price": prod.price,
      "sku": prod.sku,
      "skuid": prod.skuid,
    };
    DatabaseHelper.instance
        .updateTableData(row, "productid", prod.productId, "tblcart");
  }
}

removeProduct(tableid) async {
  print(tableid);
  dynamic data = await DatabaseHelper.instance.deleteTableData(
    tableid,
    "tblcart_id",
    "tblcart",
  );
  print(data);
}

Future<List<Map<String, dynamic>>> getCartProduct() async {
  List<Map<String, dynamic>> check =
      await DatabaseHelper.instance.queryAllTableData(table: "tblcart");
  return check;
}

placeOrder(List<Cart> product) async {
  try {
    Dio dio = Dio();
    String groupid = DateTime.now().toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString("userid");

    int type = pref.getInt('type');
    for (Cart i in product) {
      FormData form = FormData.fromMap(
        {
          "productid": i.productId,
          "yourprice": i.yourPrice,
          "skuid": i.skuid,
          "quantity": i.quantity,
          "groupid": groupid,
          "usertype": type,
          "userid": userid,
        },
      );
      await dio.post(
        api + "order/create",
        data: form,
      );
    }
    return true;
  } catch (e) {
    return false;
  }
}

class Order {
  final int sNo;
  final String product;
  final String sku;
  final String hsn;
  final String price;
  final String yourprice;
  final String date;
  Order({
    this.sNo,
    this.product,
    this.sku,
    this.hsn,
    this.price,
    this.yourprice,
    this.date,
  });
}

Future<List<Order>> getOrder() async {
  List<Order> ord = [];
  try {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString("userid");

    FormData form = FormData.fromMap(
      {
        "userid": userid,
      },
    );
    dynamic response = await dio.post(
      api + "order/view",
      data: form,
    );

    if (response.statusCode == 200) {
      dynamic data = response.data;
      int ind = 1;
      for (dynamic i in data.reversed) {
        Order o = Order(
          sNo: ind++,
          product: i['product']['product_name'],
          sku: i['sku']['category_name'],
          date: i['created_at'],
          hsn: i['product']['product_hsncode'],
          price: i['product']['product_stokistprice'],
          yourprice: i['order_userprice'],
        );
        ord.add(o);
      }
    }
  } catch (e) {
    print(e);
  }
  return ord;
}

Future<List<Order>> getOrderSM() async {
  List<Order> ord = [];
  try {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString("userid");

    FormData form = FormData.fromMap(
      {
        "userid": userid,
      },
    );
    dynamic response = await dio.post(
      api + "order/view",
      data: form,
    );

    if (response.statusCode == 200) {
      dynamic data = response.data;
      int ind = 1;
      for (dynamic i in data.reversed) {
        Order o = Order(
          sNo: ind++,
          product: i['product']['product_name'],
          sku: i['sku']['category_name'],
          date: i['created_at'],
          hsn: i['product']['product_hsncode'],
          price: i['product']['product_retailerprice'],
          yourprice: i['order_userprice'],
        );
        ord.add(o);
      }
    }
  } catch (e) {
    print(e);
  }
  return ord;
}

Future<List<Order>> getOrderD() async {
  List<Order> ord = [];
  try {
    Dio dio = Dio();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userid = pref.getString("userid");

    FormData form = FormData.fromMap(
      {
        "userid": userid,
      },
    );
    dynamic response = await dio.post(
      api + "order/view",
      data: form,
    );

    if (response.statusCode == 200) {
      dynamic data = response.data;
      int ind = 1;
      for (dynamic i in data.reversed) {
        Order o = Order(
          sNo: ind++,
          product: i['product']['product_name'],
          sku: i['sku']['category_name'],
          date: i['created_at'],
          hsn: i['product']['product_hsncode'],
          price: i['product']['product_distributorprice'],
          yourprice: i['order_userprice'],
        );
        ord.add(o);
      }
    }
  } catch (e) {
    print(e);
  }
  return ord;
}

class TotalOrder {
  final orderid;
  final oid;
  final productid;
  final sku;
  final skuid;
  final productname;
  final productimage;
  final quantity;
  final usertype;
  final offer;
  final bprice;
  final ssprice;
  final dprice;
  final rprice;
  final name;
  final email;
  final mobile;
  final address;
  final godown;
  final group;
  final status;
  TotalOrder({
    this.oid,
    this.orderid,
    this.productid,
    this.sku,
    this.skuid,
    this.productname,
    this.productimage,
    this.quantity,
    this.usertype,
    this.offer,
    this.bprice,
    this.ssprice,
    this.dprice,
    this.rprice,
    this.name,
    this.email,
    this.mobile,
    this.address,
    this.godown,
    this.group,
    this.status,
  });
}

Future<List<TotalOrder>> getAllOrder() async {
  Dio dio = Dio();
  List<TotalOrder> odata = [];
  SharedPreferences pref = await SharedPreferences.getInstance();
  String id = pref.getString("id");

  Response response = await dio.post(
    "${api}company/order",
  );
  if (response.statusCode == 200) {
    dynamic data = response.data;
    for (dynamic res in data) {
      // print("${res['user']['user_parentid']} : $id");
      if (res['user']['user_parentid'] != id) {
        continue;
      }
      TotalOrder o = TotalOrder(
        oid: res['order_id'],
        orderid: "#ORD00" + res['order_id'].toString(),
        productid: res['order_productid'],
        sku: (res['sku'] != null) ? res['sku']['category_name'] : "",
        skuid: res['order_skuid'],
        productname:
            (res['product'] != null) ? res['product']['product_name'] : "",
        productimage:
            (res['product'] != null) ? res['product']['product_image'] : "",
        quantity: res['order_quantity'],
        usertype: res['order_usertype'],
        offer: res['order_userprice'],
        bprice:
            (res['product'] != null) ? res['product']['product_baseprice'] : "",
        ssprice: (res['product'] != null)
            ? res['product']['product_stokistprice']
            : "",
        rprice: (res['product'] != null)
            ? res['product']['product_distributorprice']
            : "",
        dprice: (res['product'] != null)
            ? res['product']['product_retailerprice']
            : "",
        name: (res['user'] != null) ? res['user']['user_name'] : "",
        email: (res['user'] != null) ? res['user']['user_email'] : "",
        mobile: (res['user'] != null) ? res['user']['user_mobile'] : "",
        address: (res['user'] != null) ? res['user']['user_officeaddress'] : "",
        godown: (res['user'] != null) ? res['user']['user_godownaddress'] : "",
        group: res['order_groupid'],
        status: res['status'],
      );
      odata.add(o);
    }
  }
  return odata;
}
