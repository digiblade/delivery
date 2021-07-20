import 'dart:io';

import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class EditProduct extends StatefulWidget {
  final Product data;
  EditProduct({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  File selected;
  bool selectedFlag = false;
  double progress = 0;
  selectProfile() async {
    XFile result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      setState(() {
        selected = File(result.path);
        selectedFlag = true;
      });

      // await uploadProfile();
    }
  }

  uploadFile() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      dynamic userid = pref.getString("id");
      print("id:$userid");
      setState(() {
        selectedFlag = true;
      });

      final String apiURl = api;
      String uploadurl = "${api}company/product";
      print(uploadurl);
      FormData formdata = FormData.fromMap({
        "pImage": await MultipartFile.fromFile(selected.path,
            filename: basename(selected.path)),
        "pName": nameCtrl.text,
        "hsncode": hsnCtrl.text,
        "baseprice": priceCtrl.text,
        "sprice": sspriceCtrl.text,
        "dprice": dpriceCtrl.text,
        "rprice": retCtrl.text,
        "description": desCtrl.text,
        "id": userid,
      });
      Dio dio = Dio();
      Response responseProfile = await dio.post(
        uploadurl,
        data: formdata,
        onSendProgress: (int sent, int total) {
          String percentage = (sent / total * 100).toStringAsFixed(2);
          setState(() {
            progress = double.parse(percentage);
            //update the progress
          });
        },
      );

      if (responseProfile.statusCode == 200) {
        setState(() {
          selectedFlag = false;
        });
        dynamic data = responseProfile.data;
        if (data['success'] == true) {
          Fluttertoast.showToast(msg: "Product created successfully");
        } else {
          Fluttertoast.showToast(msg: "something went wrong");
        }
      } else {
        setState(() {
          selectedFlag = false;
        });
        Fluttertoast.showToast(msg: "something went wrong");
      }
    } catch (e, s) {
      print(e);
    }
  }

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController hsnCtrl = TextEditingController();
  final TextEditingController priceCtrl = TextEditingController();
  final TextEditingController sspriceCtrl = TextEditingController();
  final TextEditingController dpriceCtrl = TextEditingController();
  final TextEditingController retCtrl = TextEditingController();
  final TextEditingController desCtrl = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.data.productName;
    hsnCtrl.text = widget.data.hsnCode;
    priceCtrl.text = widget.data.basePrice;
  }

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
                onChange: (val) {},
                hint: "Product Name",
                controller: nameCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "HSN Code",
                onChange: (val) {},
                controller: hsnCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Base Price",
                onChange: (val) {},
                controller: priceCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Stokist Price",
                onChange: (val) {},
                controller: sspriceCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Dis. price",
                onChange: (val) {},
                controller: dpriceCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Ret. price",
                onChange: (val) {},
                controller: retCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InputField(
                hint: "Description",
                onChange: (val) {},
                controller: desCtrl,
                borderColor: secondary,
                fillColor: secondary.withOpacity(0.5),
                hintColor: Colors.black.withOpacity(0.6),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                onPressed: () {
                  selectProfile();
                },
                color: primary.withOpacity(0.7),
                height: 42,
                text: (selected != null) ? "File Selected" : "Select Image",
                textColor: light,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Button(
                onPressed: () async {
                  await uploadFile();
                },
                color: primary,
                height: 42,
                text: "Add Product $progress",
                textColor: light,
              ),
            )
          ],
        ),
      ),
    );
  }
}
