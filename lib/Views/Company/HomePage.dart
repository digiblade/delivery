import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/ProductCard.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'NavigationDrawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getCount();
  }

  int sku = 0;
  int user = 0;
  int company = 0;
  int ss = 0;
  int dis = 0;
  int asm = 0;
  int prod = 0;
  getCount() async {
    Dio dio = Dio();
    Response response = await dio.get(api + "company/dashboard");
    if (response.statusCode == 200) {
      dynamic data = response.data;
      setState(() {
        sku = data['skucount'];
        user = data['usercount'];
        company = data['companycount'];
        ss = data['sscount'];
        dis = data['distributorcount'];
        asm = data['asmcount'];
        prod = data['productcount'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: secondary,
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(
          newContext: context,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              child: Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    ProductCard(
                      onPressed: () {},
                      // bgImage: Image.asset("assets/background.jpg").image,
                      bgColor: Colors.redAccent,
                      name: "SKU Count: $sku",
                    ),
                    ProductCard(
                      onPressed: () {},
                      bgColor: Colors.greenAccent,
                      name: "User Count: $user",
                    ),
                    ProductCard(
                      onPressed: () {},
                      bgColor: Colors.amberAccent,
                      name: "Companies: $company",
                    ),
                    ProductCard(
                      onPressed: () {},
                      bgColor: Colors.cyan,
                      name: "Super Stokist: $ss",
                    ),
                    ProductCard(
                      onPressed: () {},
                      bgColor: Colors.deepOrange,
                      name: "Distributor: $dis",
                    ),
                    ProductCard(
                      onPressed: () {},
                      bgColor: Colors.deepPurple,
                      name: "Sales Manager: $asm",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
