// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Models/UserModel.dart';
import '../NavigationDrawer.dart';
import '../locationmap.dart';

class ManageUsers extends StatefulWidget {
  ManageUsers({Key key}) : super(key: key);

  @override
  _ManageUsersState createState() => _ManageUsersState();
}

class _ManageUsersState extends State<ManageUsers> {
  int val = 1;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        backgroundColor: secondary,
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(
          newContext: context,
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (BuildContext context) => AddUsers(),
      //       ),
      //     );
      //   },
      //   backgroundColor: primary,
      //   child: Icon(Icons.add),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Users",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  DropdownButton(
                    value: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Company"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Stokist"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Distributor"),
                      ),
                      DropdownMenuItem(
                        value: 4,
                        child: Text("Sales Manager"),
                      )
                    ],
                  ),
                ],
              ),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FutureBuilder(
                    future: getUserData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      index = 0;
                      if (snapshot.hasData) {
                        List<User> data = snapshot.data;
                        return DataTable(
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
                                child: Text("Email"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Type"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Firm Name"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Mobile"),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text("Office add."),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text('Godown add.'),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text('GST No.'),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text('description'),
                              ),
                            ),
                            DataColumn(
                              label: Expanded(
                                child: Text('Opration'),
                              ),
                            ),
                            // DataColumn(
                            //   label: Expanded(
                            //     child: Text('Action'),
                            //   ),
                            // ),
                          ],
                          rows: data.where((e) => (e.usertype == val)).map((e) {
                            index++;
                            return DataRow(
                              cells: [
                                DataCell(
                                  Text("$index"),
                                ),
                                DataCell(
                                  Text(
                                    e.username != null ? e.username : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.useremail != null ? e.useremail : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.usertype != null
                                        ? e.usertype.toString()
                                        : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.userfirmname != null
                                        ? e.userfirmname
                                        : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.usermobile != null ? e.usermobile : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.useroffice != null ? e.useroffice : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.usergodown != null ? e.usergodown : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.usergst != null ? e.usergst : "",
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    e.userdescription != null
                                        ? e.userdescription
                                        : "",
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          (e.usertype == 4)
                                              ? Icons.location_on
                                              : Icons.location_off,
                                          color: danger,
                                        ),
                                        onPressed: () {
                                          (e.usertype == 4)
                                              ? checkLocation(e.useremail)
                                              : Fluttertoast.showToast(
                                                  msg:
                                                      "Location Tracking not available for above user");
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                // DataCell(
                                //   Row(
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
                                //                   EditUsers(),
                                //             ),
                                //           );
                                //         },
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
                          }).toList(),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: primary,
                          ),
                        );
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

  checkLocation(String email) async {
    // dynamic location =
    //     await FirebaseFirestore.instance.collection('location').get();
    print(email);
    // print(location.data());
    // if (location.exists) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LocationPage(
          email: email,
        ),
      ),
    );
    // } else {
    //   Fluttertoast.showToast(msg: "No Location Found");
    // }
  }
}
