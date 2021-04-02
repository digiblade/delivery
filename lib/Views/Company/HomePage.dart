import 'package:delivery/Components/ProductCard.dart';
import 'package:flutter/material.dart';

import 'NavigationDrawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Color(0xFF7E2E00),
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(
          newContext: context,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductGrid(),
          ),
        ],
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        shrinkWrap: true,
        children: [
          ProductCard(
            onPressed: () {},
            // bgImage: Image.asset("assets/background.jpg").image,
            bgColor: Colors.redAccent,
            name: "Product Count: 50",
          ),
          ProductCard(
            onPressed: () {},
            bgColor: Colors.greenAccent,
            name: "User Count: 15",
          ),
          ProductCard(
            onPressed: () {},
            bgColor: Colors.amberAccent,
            name: "Super Stockist: 5",
          ),
          ProductCard(
            onPressed: () {},
            bgColor: Colors.cyan,
            name: "Distributor: 5",
          ),
          ProductCard(
            onPressed: () {},
            bgColor: Colors.deepOrange,
            name: "Retailer: 5",
          ),
          ProductCard(
            onPressed: () {},
            bgColor: Colors.deepPurple,
            name: "Sales Manager: 5",
          ),
        ],
      ),
    );
  }
}
