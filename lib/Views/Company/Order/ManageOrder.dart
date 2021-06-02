import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';

import '../NavigationDrawer.dart';

class ManageOrders extends StatefulWidget {
  ManageOrders({Key key}) : super(key: key);

  @override
  _ManageOrdersState createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
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
        onPressed: () {},
        backgroundColor: primary,
        child: Icon(Icons.search),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Orders",
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
                          child: Text("Orders ID"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("SS Name"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Address"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Quantity"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Status"),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text("Generate Bill"),
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
                            Text("#ORD123456789"),
                          ),
                          DataCell(
                            Text("Akash"),
                          ),
                          DataCell(
                            Text("5"),
                          ),
                          DataCell(
                            Text("Delivered"),
                          ),
                          DataCell(
                            Text("Active"),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(
                                Icons.print,
                                color: success,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          DataCell(
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: success,
                                  ),
                                  onPressed: () {},
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
