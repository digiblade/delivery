import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatefulWidget {
  EditProduct({Key key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: secondary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Edit Product",
                style: TextStyle(
                  fontSize: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Product Name",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Product Code",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "HSN Code",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Product Price",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Product Details",
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                onPressed: () {},
                color: primary.withOpacity(0.7),
                height: 42,
                text: "Select Image",
                textColor: light,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                onPressed: () {},
                color: primary,
                height: 42,
                text: "Add Product",
                textColor: light,
              ),
            )
          ],
        ),
      ),
    );
  }
}
