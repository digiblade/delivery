// import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

import 'SSnavigator.dart';

class SSOrder extends StatefulWidget {
  SSOrder({Key key}) : super(key: key);

  @override
  _SSOrderState createState() => _SSOrderState();
}

class _SSOrderState extends State<SSOrder> {
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
      body: PurchaseBody(),
    );
  }
}

class PurchaseBody extends StatefulWidget {
  const PurchaseBody({Key key}) : super(key: key);

  @override
  _PurchaseBodyState createState() => _PurchaseBodyState();
}

class _PurchaseBodyState extends State<PurchaseBody> {
  final TextEditingController quantity = TextEditingController();
  @override
  void initState() {
    super.initState();
    quantity.text = "1";
  }

  checkIsDouble(String data) {
    try {
      quantity.text = (double.parse(data)).toString();
    } catch (e) {
      quantity.text = "1";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              color: primary,
              child: Text(
                "Total Price",
                style: TextStyle(color: light),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: Image.network(
                    "https://digiblade.in/popposapi/images/biryani.jpeg",
                  ).image,
                ),
                title: Text("Product Name"),
                subtitle: Text("10Kg x 3"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
