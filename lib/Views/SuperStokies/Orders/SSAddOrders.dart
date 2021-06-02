import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:flutter/material.dart';

class AddOrders extends StatefulWidget {
  AddOrders({Key key}) : super(key: key);

  @override
  _AddOrdersState createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
        backgroundColor: secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Add Orders",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: " Name",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Type",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "City",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "State",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Status",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                onPressed: () {},
                color: primary,
                height: 42,
                text: "Add User",
                textColor: light,
              ),
            )
          ],
        ),
      ),
    );
  }
}
