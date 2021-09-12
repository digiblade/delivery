import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../NavigationDrawer.dart';

class ManageOrders extends StatefulWidget {
  ManageOrders({Key key}) : super(key: key);

  @override
  _ManageOrdersState createState() => _ManageOrdersState();
}

class _ManageOrdersState extends State<ManageOrders> {
  final TextEditingController ctrl = TextEditingController();
  bool flag = false;
  String status = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: secondary,
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(
          newContext: context,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            flag = !flag;
          });
        },
        backgroundColor: primary,
        child: Icon((flag) ? Icons.cancel_presentation_outlined : Icons.search),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
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
                  SingleChildScrollView(
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: FutureBuilder(
                          future: getAllOrder(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              int index = 1;
                              List<TotalOrder> data = snapshot.data;
                              if (data.length == 0) {
                                return Center(
                                  child: Text("No Order Found"),
                                );
                              }

                              return DataTable(
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
                                        child: Text("User Name"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Email"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Mobile"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Office Address"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Godown Address"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Product name"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("SKU"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Quantity"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Price"),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Container(
                                          width: 8,
                                          child: Text("Request"),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Expanded(
                                        child: Text("Status"),
                                      ),
                                    ),
                                    // DataColumn(
                                    //   label: Expanded(
                                    //     child: Text("Generate Bill"),
                                    //   ),
                                    // ),
                                  ],
                                  rows: data.where((e) {
                                    if (!flag) {
                                      return true;
                                    }
                                    if (ctrl.text.length == 0) {
                                      return true;
                                    } else {
                                      return e.orderid
                                              .toString()
                                              .toUpperCase() ==
                                          ctrl.text.toUpperCase();
                                    }
                                  }).map((e) {
                                    return DataRow(
                                      cells: [
                                        DataCell(
                                          Text("${index++}"),
                                        ),
                                        DataCell(
                                          Text("${e.orderid}"),
                                        ),
                                        DataCell(
                                          Text("${e.name}"),
                                        ),
                                        DataCell(
                                          Text("${e.email}"),
                                        ),
                                        DataCell(
                                          Text("${e.mobile}"),
                                        ),
                                        DataCell(
                                          Text("${e.address}"),
                                        ),
                                        DataCell(
                                          Text("${e.godown}"),
                                        ),
                                        DataCell(
                                          Text("${e.productname}"),
                                        ),
                                        DataCell(
                                          Text("${e.sku}"),
                                        ),
                                        DataCell(
                                          Text("${e.quantity}"),
                                        ),
                                        DataCell(
                                          Text("${e.bprice}"),
                                        ),
                                        DataCell(
                                          Text("${e.offer}"),
                                        ),
                                        DataCell(
                                          DropdownButton(
                                            onChanged: (val) async {
                                              try {
                                                if (val == e.status) {
                                                  return;
                                                }
                                                _openLoadingDialog(context);
                                                Dio dio = Dio();
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();
                                                String userid =
                                                    pref.getString("userid");
                                                String id =
                                                    pref.getString("id");
                                                FormData form =
                                                    FormData.fromMap({
                                                  "cid": int.parse(id),
                                                  "pid": e.productid,
                                                  "sid": e.skuid,
                                                  // "oid": e.orderid,
                                                  "uid": "$userid",
                                                  "qty": e.quantity,
                                                  "price": (val == "CONFIRM")
                                                      ? e.bprice
                                                      : (e.offer != "NA")
                                                          ? e.offer
                                                          : 0,
                                                  "id": e.oid,
                                                  "status": val,
                                                });
                                                Response response =
                                                    await dio.post(
                                                  api + "stock/changeStatus",
                                                  data: form,
                                                );
                                                if (response.statusCode ==
                                                    200) {
                                                  dynamic data = response.data;
                                                  print(data);
                                                }
                                                setState(() {});
                                                Navigator.pop(context);
                                              } catch (e) {
                                                print(e.response);
                                              }
                                            },
                                            value: e.status,
                                            items: [
                                              if (e.status == "PENDING")
                                                DropdownMenuItem(
                                                  value:
                                                      "pending".toUpperCase(),
                                                  child: Text(
                                                    "pending".toUpperCase(),
                                                  ),
                                                ),
                                              if (e.status ==
                                                      "Accept request"
                                                          .toUpperCase() ||
                                                  e.status == "PENDING")
                                                DropdownMenuItem(
                                                  value: "Accept request"
                                                      .toUpperCase(),
                                                  child: Text(
                                                    "Accept request"
                                                        .toUpperCase(),
                                                  ),
                                                ),
                                              if (e.status ==
                                                      "Confirm".toUpperCase() ||
                                                  e.status == "PENDING")
                                                DropdownMenuItem(
                                                  value:
                                                      "Confirm".toUpperCase(),
                                                  child: Text(
                                                    "Confirm".toUpperCase(),
                                                  ),
                                                ),
                                              if (e.status != "PENDING")
                                                DropdownMenuItem(
                                                  value:
                                                      "Delivered".toUpperCase(),
                                                  child: Text(
                                                    "Delivered".toUpperCase(),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          // Text("${e.status}"),
                                        ),
                                        // DataCell(
                                        //   IconButton(
                                        //     icon: Icon(
                                        //       Icons.print,
                                        //       color: success,
                                        //     ),
                                        //     onPressed: () {},
                                        //   ),
                                        // ),
                                        // DataCell(
                                        //   Row(
                                        //     children: [
                                        //       IconButton(
                                        //         icon: Icon(
                                        //           Icons.edit,
                                        //           color: success,
                                        //         ),
                                        //         onPressed: () {},
                                        //       ),
                                        //       IconButton(
                                        //         icon: Icon(
                                        //           Icons.delete,
                                        //           color: danger,
                                        //         ),
                                        //         onPressed: () {},
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                      ],
                                    );
                                  }).toList());
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (flag)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                borderColor: primary,
                fillColor: light,
                hintColor: dark,
                hint: "Search By Orderid",
                onChange: (val) {
                  setState(() {
                    ctrl.text = val;
                  });
                },
                controller: ctrl,
              ),
            ),
        ],
      ),
    );
  }

  void _openLoadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: SizedBox(
            height: 64,
            width: 64,
            child: FittedBox(
              fit: BoxFit.contain,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primary),
              ),
            ),
          ),
        );
      },
    );
  }
}
