import 'package:flutter/material.dart';

class NavigatorDrawer extends StatelessWidget {
  const NavigatorDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xFF7E2E00)),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 32,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: Image.asset("assets/user.png").image,
                      ),
                      Text(
                        "Akash Chourasia",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Manager In Development",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 16,
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
                        color: Colors.green,
                        size: 16,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text(
              "View User",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            subtitle: Text("Manage All User"),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text(
              "View Delivery",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            subtitle: Text("Manage All Delivery"),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text(
              "View Orders",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            subtitle: Text("Manage All Orders"),
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
