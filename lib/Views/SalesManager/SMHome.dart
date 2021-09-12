import 'package:animations/animations.dart';
// import 'package:delivery/Components/CategorySlider.dart';
import 'package:delivery/Components/Color.dart';
// import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:flutter/material.dart';

import 'SMnavigator.dart';
import 'SSPurchase.dart';

class SMHome extends StatefulWidget {
  SMHome({Key key}) : super(key: key);

  @override
  _SMHomeState createState() => _SMHomeState();
}

class _SMHomeState extends State<SMHome> {
  @override
  Widget build(BuildContext context) {
    print("======>");
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Manager"),
        backgroundColor: primary,
      ),
      endDrawer: Drawer(
        child: SMNavigator(
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
                "Products",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              // ProductGrid(
              //   onTap: navigate,
              // )
              Container(
                child: FutureBuilder(
                  future: getProductById(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Product> data = snapshot.data;
                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        shrinkWrap: true,
                        primary: false,
                        children: data.where((e) => e.sku.length > 0).map(
                          (e) {
                            return OpenContainer(
                              closedBuilder: (context, action) => ProductCard(
                                image: e.image,
                                price: e.distributorPrice,
                                name: e.productName,
                                description: e.description,
                              ),
                              openBuilder: (context, action) => SMPurchase(
                                prod: e,
                              ),
                            );
                          },
                        ).toList(),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String image;
  final String price;
  final String name;
  final String description;
  const ProductCard({
    Key key,
    this.image = "",
    this.price = "",
    this.name = "",
    this.description = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.network(
            imageurl + "product/" + image,
          ).image,
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                // width: double.infinity,
                color: primary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 8,
                  ),
                  child: Text(
                    (price != null) ? price + " /-" : "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: light,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // width: double.infinity,/
              color: light,
              child: ListTile(
                title: Text(
                  name ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  description ?? "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
