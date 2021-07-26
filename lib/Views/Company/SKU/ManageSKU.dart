import 'package:delivery/Components/Color.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../NavigationDrawer.dart';
import 'AddSKU.dart';
import 'EditSKU.dart';

class ManageSKU extends StatefulWidget {
  ManageSKU({Key key}) : super(key: key);

  @override
  _ManageSKUState createState() => _ManageSKUState();
}

class _ManageSKUState extends State<ManageSKU> {
  callBack() {
    setState(() {});
  }

  delete(int id) async {
    try {
      Dio dio = Dio();
      await dio.get(api + "company/deletecategory/$id");
      Fluttertoast.showToast(msg: "Sku delete successfully");
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
              builder: (BuildContext context) => AddSKU(
                callBack: callBack,
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
                "SKU",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future: getSKU(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return Center(child: Text("No Product Found"));
                        }
                        List<SKU> data = snapshot.data;
                        return DataTable(
                          columns: [
                            DataColumn(
                              label: Expanded(
                                child: Text("S/No."),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("SKU Image"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("SKU"),
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
                                    "$imageurl/categories/${e.skuimage}",
                                    height: 64,
                                    width: 64,
                                  ),
                                ),
                                DataCell(
                                  Text("${e.skuname}"),
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
                                                  EditSKU(
                                                data: e,
                                                callBack: callBack,
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
                                        onPressed: () {
                                          delete(e.skuid);
                                        },
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
