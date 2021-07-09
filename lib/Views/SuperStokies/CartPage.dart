import 'package:delivery/Components/Color.dart';
import 'package:delivery/Database/DatabaseHelper.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:flutter/material.dart';

import 'SSnavigator.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);
  getCartProduct() async {
    List<Map<String, dynamic>> check =
        await DatabaseHelper.instance.queryAllTableData(table: "tblcart");
    List<Cart> cart = [];
    for (dynamic res in check) {
      Cart c = Cart(
        productId: res['productid'],
        productImage: res['image'],
        productName: res['productname'],
        quantity: res['quantity'],
        yourPrice: res['yourprice'],
      );
      cart.add(c);
    }
    return cart;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Super Stockist"),
          backgroundColor: primary,
        ),
        endDrawer: Drawer(
          child: SSNavigator(
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
                        warning.withRed(20),
                      ),
                    ),
                    onPressed: () {},
                    child: Wrap(
                      children: [
                        Text("Proceed Order with "),
                        Text("Total: 14000/-"),
                      ],
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
                        List<Map<String, dynamic>> data = snapshot.data;
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
                                  image: e['productImage'],
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
  final String image;
  CartProduct({
    Key key,
    this.image,
  }) : super(key: key);

  @override
  _CartProductState createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: Image.network(
            imageurl + "product/" + widget.image,
          ).image,
        ),
        title: Text("product name"),
        subtitle: Text(
          "qty. 1, price: 150/- " "\n" "your price",
        ),
        trailing: GestureDetector(
          onTap: () {},
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
