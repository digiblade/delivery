import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';

import 'Orders/SSManageOrders.dart';

class SSNavigator extends StatelessWidget {
  final BuildContext? newContext;
  const SSNavigator({
    Key? key,
    this.newContext,
  }) : super(key: key);

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
                    height: 200,
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundImage:
                                    Image.asset("assets/user.jpg").image,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Akash Chourasia",
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
                                horizontal: 8.0, vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Super stokist",
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
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  color: light,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context);
                    // Navigator.push(
                    //   newContext!,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => ManageProduct(),
                    //   ),
                    // );
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
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ManageOrders(),
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
                Divider(
                  color: Colors.black,
                ),
                ListTile(
                  leading: Icon(
                    Icons.supervised_user_circle,
                    size: 32,
                  ),
                  title: Text(
                    "Manage Stocks",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    "Manage Product Stocks",
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   newContext!,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => ManageUsers(),
                    //   ),
                    // );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      size: 32,
                    ),
                    title: Text(
                      "Manage Distributors",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Manage All Distributors",
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // Navigator.push(
                    //   newContext!,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) => ManageOrders(),
                    //   ),
                    // );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.supervised_user_circle,
                      size: 32,
                    ),
                    title: Text(
                      "Manage Distributors Orders",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text("Manage All Orders"),
                  ),
                ),
                Divider(
                  color: Colors.black,
                ),
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
                      print("logout");
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
