import 'package:delivery/Components/Color.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../NavigationDrawer.dart';
import 'AddManu.dart';
import 'EditManu.dart';

class ManageManu extends StatefulWidget {
  final int pid;

  ManageManu({
    Key key,
    this.pid,
  }) : super(key: key);

  @override
  _ManageManuState createState() => _ManageManuState();
}

class _ManageManuState extends State<ManageManu> {
  callBack() {
    setState(() {});
  }

  delete(int id) async {
    try {
      Dio dio = Dio();
      await dio.get(api + "company/deleteproduct/$id");
      Fluttertoast.showToast(msg: "Product delete successfully");
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manufacturing"),
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
              builder: (BuildContext context) => AddManu(
                callBack: callBack,
                pid: widget.pid,
              ),
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
                "Manufacturing",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future: getManu(widget.pid),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(child: Text("No Product Found"));
                        }
                        List<Manufacturing> data = snapshot.data;
                        return DataTable(
                          columns: [
                            DataColumn(
                              label: Expanded(
                                child: Text("S/No."),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Product name"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Code"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Sku"),
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
                                child: Text("Total"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Remaining"),
                              ),
                            ),
                            // DataColumn(
                            //   label: Expanded(
                            //     child: Text("Action"),
                            //   ),
                            // ),
                          ],
                          rows: data.map((e) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text("${e.index}"),
                                ),
                                DataCell(
                                  Text("${e.productname}"),
                                ),
                                DataCell(
                                  Text("${e.code}"),
                                ),
                                DataCell(
                                  Text("${e.skuname}"),
                                ),
                                DataCell(
                                  Text("${e.bprice}"),
                                ),
                                DataCell(
                                  Text(
                                    "${e.ssprice}",
                                  ),
                                ),
                                DataCell(
                                  Text("${e.dprice}"),
                                ),
                                DataCell(
                                  Text("${e.rprice}"),
                                ),
                                DataCell(
                                  Text("${e.total}"),
                                ),
                                DataCell(
                                  Text(
                                      "${int.parse(e.total) - int.parse(e.sold)}"),
                                ),
                                // DataCell(
                                //   Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     children: [
                                //       IconButton(
                                //         icon: Icon(
                                //           Icons.edit,
                                //           color: success,
                                //         ),
                                //         onPressed: () {
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (BuildContext context) =>
                                //                   EditManu(
                                //                 // data: e,
                                //                 callBack: callBack,
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //       ),
                                //       IconButton(
                                //         icon: Icon(
                                //           Icons.delete,
                                //           color: danger,
                                //         ),
                                //         onPressed: () {
                                //           delete(e.id);
                                //         },
                                //       ),
                                //     ],
                                //   ),
                                // ),
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
