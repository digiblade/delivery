import 'package:delivery/Components/Color.dart';
import 'package:delivery/Views/SuperStokies/SSnavigator.dart';
import 'package:flutter/material.dart';

import 'SSAddOrders.dart';
import 'SSEditOrders.dart';

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
        title: Text("Orders"),
        backgroundColor: primary,
      ),
      endDrawer: Drawer(
        child: SSNavigator(
          newContext: context,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddOrders(),
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
                                            EditOrders(),
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
