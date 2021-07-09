import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'SSnavigator.dart';

class SMpurchase extends StatefulWidget {
  SMpurchase({Key key}) : super(key: key);

  @override
  _SMpurchaseState createState() => _SMpurchaseState();
}

class _SMpurchaseState extends State<SMpurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Manager"),
        backgroundColor: primary,
      ),
      endDrawer: Drawer(),
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
    quantity.text = "0";
  }

  checkIsDouble(String data) {
    try {
      quantity.text = (int.parse(data)).toString();
    } catch (e) {
      quantity.text = "0";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: double.infinity,
            child: Image.network(
              "https://digiblade.in/popposapi/images/biryani.jpeg",
              // width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Price: INR 160/-",
                style: TextStyle(
                  fontSize: 20,
                  color: grey,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Product Name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "10Kg",
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
                color: grey,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ",
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              "Create Order",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    int qty = int.parse(quantity.text);

                    setState(() {
                      if (qty != 0) {
                        quantity.text = (--qty).toString();
                      }
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: InputField(
                    onChange: (val) {
                      checkIsDouble(quantity.text);
                    },
                    controller: quantity,
                    keyType: TextInputType.number,
                    borderColor: primary,
                    fillColor: light.withOpacity(0.2),
                    hint: "Quantity",
                  ),
                ),
                IconButton(
                  onPressed: () {
                    int qty = int.parse(quantity.text);

                    setState(() {
                      quantity.text = (++qty).toString();
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InputField(
              borderColor: primary.withOpacity(0.6),
              fillColor: light.withOpacity(0.1),
              hint: "Your Price",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(
              onPressed: () {
                Fluttertoast.showToast(msg: "Product added in cart");
              },
              text: "Buy",
            ),
          ),
        ],
      ),
    );
  }
}
