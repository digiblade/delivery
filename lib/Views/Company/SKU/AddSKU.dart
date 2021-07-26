import 'dart:io';

import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class AddSKU extends StatefulWidget {
  final Function() callBack;
  AddSKU({
    Key key,
    this.callBack,
  }) : super(key: key);

  @override
  _AddSKUState createState() => _AddSKUState();
}

class _AddSKUState extends State<AddSKU> {
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

      String uploadurl = "${api}company/category/add";
      print(uploadurl);
      FormData formdata = FormData.fromMap({
        "cImage": await MultipartFile.fromFile(selected.path,
            filename: basename(selected.path)),
        "cName": nameCtrl.text,
        // "hsncode": hsnCtrl.text,
        // "baseprice": priceCtrl.text,
        // "sprice": sspriceCtrl.text,
        // "dprice": dpriceCtrl.text,
        // "rprice": retCtrl.text,
        // "description": desCtrl.text,
        // "id": userid,
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
        print(data);
        if (data['response'] == true) {
          Fluttertoast.showToast(msg: "SKU created successfully");
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
      print(e);
    }
  }

  final TextEditingController nameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.callBack();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("SKU"),
          backgroundColor: secondary,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add SKU",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputField(
                  onChange: (val) {},
                  hint: "Sku Name",
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
                  text: "Add SKU $progress",
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
