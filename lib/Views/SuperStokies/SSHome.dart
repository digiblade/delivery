import 'package:delivery/Components/CategorySlider.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Views/SuperStokies/SSnavigator.dart';
import 'package:flutter/material.dart';

class SSHome extends StatefulWidget {
  SSHome({Key? key}) : super(key: key);

  @override
  _SSHomeState createState() => _SSHomeState();
}

class _SSHomeState extends State<SSHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Super Stockist"),
        backgroundColor: primary,
      ),
      endDrawer: Drawer(
        child: SSNavigator(
          newContext: context,
        ),
      ),
      body: HorizontalSlider(),
    );
  }
}
