// import 'package:delivery/Components/CategorySlider.dart';
import 'package:delivery/Components/Color.dart';
// import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:delivery/Views/SuperStokies/SSnavigator.dart';
import 'package:flutter/material.dart';

class MyOrder extends StatefulWidget {
  MyOrder({Key key}) : super(key: key);

  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My orders"),
        backgroundColor: primary,
      ),
      endDrawer: Drawer(
        child: SSNavigator(
          newContext: context,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Orders",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              FutureBuilder(
                future: getOrder(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<Order> data = snapshot.data;
                    if (data.length > 0) {
                      return Column(
                        children: data.map((e) {
                          return OrderCard(
                            count: e.sNo,
                            product: e.product,
                            date: e.date,
                            hsn: e.hsn,
                            productPrice: e.price,
                            sku: e.sku,
                            yPrice: e.yourprice,
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Text("No Order Found"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final int count;
  final String product;
  final String sku;
  final String hsn;
  final String productPrice;
  final String yPrice;
  final String date;
  const OrderCard({
    Key key,
    this.count = 0,
    this.product = "",
    this.sku = "",
    this.hsn = "",
    this.productPrice = "",
    this.yPrice = "",
    this.date = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primary,
          child: Text("#$count"),
        ),
        title: Text(product),
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("SKU: $sku"),
            Text("HSN: $hsn"),
            Text("Product price: INR $productPrice/-"),
            Text("Your price: $yPrice/-"),
            Text("$date"),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: danger,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Pending",
                  style: TextStyle(
                    color: light,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
