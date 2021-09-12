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

class EditSKU extends StatefulWidget {
  final Function() callBack;
  final SKU data;
  EditSKU({
    Key key,
    this.data,
    this.callBack,
  }) : super(key: key);

  @override
  _EditSKUState createState() => _EditSKUState();
}

class _EditSKUState extends State<EditSKU> {
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
      // int id = widget.data.skuid;
      String uploadurl = "${api}company/category/edit";
      print(uploadurl);
      FormData formdata;
      if (selected != null) {
        formdata = FormData.fromMap({
          "cImage": await MultipartFile.fromFile(selected.path,
              filename: basename(selected.path)),
          "cName": nameCtrl.text,
          "id": widget.data.skuid,
        });
      } else {
        formdata = FormData.fromMap({
          "cName": nameCtrl.text,
          "id": widget.data.skuid,
        });
      }

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
        if (data['response'] == true) {
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
    } catch (e) {
      print(e.response);
    }
  }

  final TextEditingController nameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.text = widget.data.skuname;
    // hsnCtrl.text = widget.data.hsnCode;
    // priceCtrl.text = widget.data.basePrice;
    // sspriceCtrl.text = widget.data.stokistPrice;
    // dpriceCtrl.text = widget.data.distributorPrice;
    // retCtrl.text = widget.data.retailerPrice;
    // desCtrl.text = widget.data.description;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.callBack();
        return true;
      },
      child: Scaffold(
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
                  text: "Edit sku $progress",
                  textColor: light,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
