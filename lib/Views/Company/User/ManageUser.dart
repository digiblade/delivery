import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';

import '../NavigationDrawer.dart';
import 'AddUser.dart';
import 'EditUser.dart';

class ManageProduct extends StatefulWidget {
  ManageProduct({Key? key}) : super(key: key);

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
                "Users",
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
                          child: Text("User Name"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("User Type"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("City"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("State"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Status"),
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
                            Text("Akash"),
                          ),
                          DataCell(
                            Text("Distributor"),
                          ),
                          DataCell(
                            Text("Bilaspur"),
                          ),
                          DataCell(
                            Text("Chhattissgarh"),
                          ),
                          DataCell(
                            Text("Active"),
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
