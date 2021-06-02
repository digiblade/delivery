import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'NavigationDrawer.dart';
import 'locationmap.dart';

class UserData extends StatefulWidget {
  UserData({Key key}) : super(key: key);

  @override
  _UserDataState createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UserPage"),
        backgroundColor: Color(0xFF7E2E00),
      ),
      endDrawer: Drawer(
        child: NavigatorDrawer(),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: firestore.collection("user").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> ass) {
            if (ass.hasError) {
              return Text('Something went wrong');
            }

            if (ass.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Column(
              children: ass.data.docs.map<Widget>((e) {
                return UserCard(
                  name: e.data()['name'],
                  subTitle: e.data()['subtitle'],
                  email: e.data()['email'],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String name;
  final String subTitle;
  final String email;

  const UserCard({
    Key key,
    this.name,
    this.subTitle,
    this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => LocationPage(
                email: email,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: Image.asset("assets/user.png").image,
          ),
          title: Text(name),
          subtitle: Text(subTitle),
        ),
      ),
    );
  }
}
