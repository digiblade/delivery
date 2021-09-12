import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:flutter/material.dart';
import 'SalesHome.dart';

class DResponse extends StatelessWidget {
  final bool response;
  const DResponse({
    Key key,
    this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * .3,
                ),
                Icon(
                  (response) ? Icons.check_circle : Icons.error_outline,
                  color: (response) ? success : danger,
                  size: 48,
                ),
                SizedBox(
                  height: 32,
                ),
                Text(
                  (response)
                      ? "Order placed successfully"
                      : "Please try again leter",
                  style: TextStyle(
                    color: (response) ? success : danger,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Button(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SMHome(),
                      ),
                    );
                  },
                  color: (response) ? success : danger,
                  text: "Go Back",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
