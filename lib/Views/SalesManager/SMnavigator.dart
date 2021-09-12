import 'package:delivery/Models/Authmodel.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SMCartPage.dart';
import 'SMHome.dart';
import 'SMMyorder.dart';

// import 'Orders/SSManageOrders.dart';

class SMNavigator extends StatefulWidget {
  final BuildContext newContext;
  const SMNavigator({
    Key key,
    this.newContext,
  }) : super(key: key);

  @override
  _SMNavigatorState createState() => _SMNavigatorState();
}

class _SMNavigatorState extends State<SMNavigator> {
  String email = "";
  @override
  void initState() {
    super.initState();
    getLogin();
  }

  getLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      email = pref.getString("userid");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset("assets/office.jpg").image,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7),
                        BlendMode.srcOver,
                      ),
                    ),
                  ),
                  child: Container(
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "$email",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sales Manager",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      "Online",
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.fiber_manual_record,
                                      color: Colors.greenAccent,
                                      size: 16,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: GestureDetector(
                          //     child: Text(
                          //       "Edit Profile",
                          //       style: TextStyle(
                          //         color: light,
                          //         fontSize: 16,
                          //         fontWeight: FontWeight.bold,
                          //       ),
                          //     ),
                          //     onTap: () {},
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      widget.newContext,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SMHome(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      size: 32,
                    ),
                    title: Text(
                      "Buy Products",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text("All Products"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      widget.newContext,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SMCartPage(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      size: 32,
                    ),
                    title: Text(
                      "View Cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text("All Products"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SMMyOrder(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      size: 32,
                    ),
                    title: Text(
                      "My Orders",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Manage Orders",
                    ),
                  ),
                ),
                // Divider(
                //   color: Colors.black,
                // ),
                // ListTile(
                //   leading: Icon(
                //     Icons.supervised_user_circle,
                //     size: 32,
                //   ),
                //   title: Text(
                //     "Manage Stocks",
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //     ),
                //   ),
                //   subtitle: Text(
                //     "Manage Product Stocks",
                //   ),
                // ),
                // Divider(
                //   color: Colors.black,
                // ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Navigator.push(
                //     //   newContext!,
                //     //   MaterialPageRoute(
                //     //     builder: (BuildContext context) => ManageUsers(),
                //     //   ),
                //     // );
                //   },
                //   child: ListTile(
                //     leading: Icon(
                //       Icons.supervised_user_circle,
                //       size: 32,
                //     ),
                //     title: Text(
                //       "Manage Distributors",
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 20,
                //       ),
                //     ),
                //     subtitle: Text(
                //       "Manage All Distributors",
                //     ),
                //   ),
                // ),
                Divider(
                  color: Colors.black,
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.pop(context);
                //     // Navigator.push(
                //     //   newContext!,
                //     //   MaterialPageRoute(
                //     //     builder: (BuildContext context) => ManageOrders(),
                //     //   ),
                //     // );
                //   },
                //   child: ListTile(
                //     leading: Icon(
                //       Icons.supervised_user_circle,
                //       size: 32,
                //     ),
                //     title: Text(
                //       "Manage Orders",
                //       style: TextStyle(
                //         color: Colors.black,
                //         fontSize: 20,
                //       ),
                //     ),
                //     subtitle: Text("Manage All Orders"),
                //   ),
                // ),
                // Divider(
                //   color: Colors.black,
                // ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 64,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image.asset("assets/office.jpg").image,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.7),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  TextButton(
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      logout();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/logout',
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
