import 'package:delivery/Components/Color.dart';
import 'package:delivery/Database/DatabaseHelper.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:flutter/material.dart';

import 'Response.dart';
import 'Dnavigator.dart';

class DCartPage extends StatefulWidget {
  const DCartPage({Key key}) : super(key: key);

  @override
  _DCartPageState createState() => _DCartPageState();
}

class _DCartPageState extends State<DCartPage> {
  bool flag = true;
  refresh() {
    setState(() {
      getCartProduct();
      getTotal();
    });
  }

  double totalData = 0;
  Future<List<Cart>> getCartProduct() async {
    List<Cart> cart = [];
    try {
      List<Map<String, dynamic>> check =
          await DatabaseHelper.instance.queryAllTableData(table: "tblcart");

      for (dynamic res in check) {
        print(res);
        Cart c = Cart(
          productId: res['productid'],
          productImage: res['image'],
          productName: res['productname'],
          quantity: res['quantity'],
          yourPrice: (res['yourprice']).toString(),
          sku: res['sku'],
          skuid: res['skuid'],
          price: res['price'].toString(),
          tableid: res['tblcart_id'],
        );
        cart.add(c);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }

    return cart;
  }

  getTotal() async {
    List<Cart> data = await getCartProduct();
    double total = 0;
    for (Cart i in data) {
      total += double.parse(i.price) * i.quantity;
    }
    setState(() {
      totalData = total;
    });
  }

  @override
  void initState() {
    super.initState();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Distributor"),
          backgroundColor: primary,
        ),
        endDrawer: Drawer(
          child: DNavigator(
            newContext: context,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        success,
                      ),
                    ),
                    onPressed: () async {
                      if (flag) {
                        List<Cart> data = await getCartProduct();
                        if (data.length > 0) {
                          setState(() {
                            flag = false;
                          });
                        } else {
                          return false;
                        }

                        bool check = await placeOrder(await getCartProduct());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => DResponse(
                              response: check,
                            ),
                          ),
                        );
                        if (check) {
                          await DatabaseHelper.instance
                              .truncateTable("tblcart");
                        }
                        setState(() {
                          flag = true;
                        });
                      }
                    },
                    child: (flag)
                        ? Wrap(
                            children: [
                              Text("Proceed Order with "),
                              Text("Total: $totalData/-"),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(primary),
                            ),
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: getCartProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Cart> data = snapshot.data;
                        if (data.length == 0) {
                          return Center(
                            child: Text("No product added into cart"),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Column(
                              children: data.map((e) {
                                return CartProduct(
                                  productName: e.productName,
                                  image: e.productImage ?? "",
                                  qty: e.quantity.toString(),
                                  productPrice: e.price,
                                  yourprice: e.yourPrice,
                                  tableid: e.tableid,
                                  callback: refresh,
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartProduct extends StatefulWidget {
  final String productName;
  final String image;
  final String productPrice;
  final String qty;
  final String yourprice;
  final int tableid;
  final int skuid;
  final Function callback;
  CartProduct({
    Key key,
    this.productName = "",
    this.image,
    this.productPrice,
    this.qty = "0",
    this.yourprice,
    this.tableid,
    this.skuid,
    this.callback,
  }) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    // print(widget.image);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: Image.network(
            imageurl + "product/" + widget.image,
          ).image,
        ),
        title: Text(widget.productName),
        subtitle: Text(
          "qty. ${widget.qty}, price: ${widget.productPrice}/- "
          "\n"
          "your price: ${widget.yourprice}",
        ),
        trailing: GestureDetector(
          onTap: () async {
            print(widget.tableid);
            await removeProduct(widget.tableid);
            widget.callback();
          },
          child: Container(
            decoration: BoxDecoration(
              color: danger.withRed(200),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.delete,
                color: light,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
