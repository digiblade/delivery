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
        title: Text("All User"),
        backgroundColor: Color(0xFF7E2E00),
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(),
      ),
      body: Column(
        children: [
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
          ProductCard(),
          ProductCard(),
          ProductCard(),
          ProductCard(),
        ],
      ),
    );
  }
}
