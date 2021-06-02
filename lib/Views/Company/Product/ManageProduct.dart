import 'package:delivery/Components/Color.dart';
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
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Expanded(
                          child: Text("S/No."),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Product Name"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Product Code"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("HSN Code"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Product Price"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Product Details"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Image"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Is In Stock"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Action"),
                        ),
                      ),
                    ],
                    rows: [
                      DataRow(
                        cells: [
                          DataCell(
                            Text("1"),
                          ),
                          DataCell(
                            Text("Laptop"),
                          ),
                          DataCell(
                            Text("123456789"),
                          ),
                          DataCell(
                            Text("STK12546789"),
                          ),
                          DataCell(
                            Text("1,22,222"),
                          ),
                          DataCell(
                            Container(
                              width: 128,
                              child: Text(
                                "sk;dmk smd kdsksdfk sd;kfmds kfsd sd dskl lskdng lksdgkldsng lsn gl l",
                              ),
                            ),
                          ),
                          DataCell(
                            Text("image 1"),
                          ),
                          DataCell(
                            Text("True"),
                          ),
                          DataCell(Row(
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
                                            EditProduct(),
                                      ),
                                    );
                                  }),
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: danger,
                                  ),
                                  onPressed: () {}),
                            ],
                          )),
                        ],
                      ),
                    ],
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
