import 'package:delivery/Components/Color.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:flutter/material.dart';

import '../NavigationDrawer.dart';
import 'AddProduct.dart';
import 'EditProduct.dart';

class ManageProduct extends StatefulWidget {
  ManageProduct({Key key}) : super(key: key);

  @override
  _ManageProductState createState() => _ManageProductState();
}

class _ManageProductState extends State<ManageProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: secondary,
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(
          newContext: context,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddProduct(),
            ),
          );
        },
        backgroundColor: primary,
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Products",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future: getProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(child: Text("No Product Found"));
                        }
                        List<Product> data = snapshot.data;
                        return DataTable(
                          columns: [
                            DataColumn(
                              label: Expanded(
                                child: Text("S/No."),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Image"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Product Name"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("HSN Code"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Price"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("SS price"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Dis. price"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Retailer price"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Action"),
                              ),
                            ),
                          ],
                          rows: data.map((e) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text("${e.index}"),
                                ),
                                DataCell(
                                  Image.network(
                                    "$imageurl/product/${e.image}",
                                    height: 64,
                                    width: 64,
                                  ),
                                ),
                                DataCell(
                                  Text("${e.productName}"),
                                ),
                                DataCell(
                                  Text("${e.hsnCode}"),
                                ),
                                DataCell(
                                  Text("${e.basePrice}"),
                                ),
                                DataCell(
                                  Text("${e.stokistPrice}"),
                                ),
                                DataCell(
                                  Container(
                                    width: 128,
                                    child: Text(
                                      "${e.distributorPrice}",
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text("${e.retailerPrice}"),
                                ),
                                // DataCell(
                                //   Text("${e.index}"),
                                // ),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: success,
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  EditProduct(
                                                data: e,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: danger,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
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
