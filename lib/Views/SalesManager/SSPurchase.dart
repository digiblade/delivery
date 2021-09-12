import 'package:delivery/Components/Button.dart';
import 'package:delivery/Components/Color.dart';
import 'package:delivery/Components/InputField.dart';
import 'package:delivery/Models/ProductModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:delivery/Models/AllUrl.dart';
import 'SMnavigator.dart';

class SMPurchase extends StatefulWidget {
  final Product prod;
  SMPurchase({
    Key key,
    this.prod,
  }) : super(key: key);

  @override
  _SMPurchaseState createState() => _SMPurchaseState();
}

class _SMPurchaseState extends State<SMPurchase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Manager"),
        backgroundColor: primary,
      ),
      endDrawer: Drawer(
        child: SMNavigator(
          newContext: context,
        ),
      ),
      body: PurchaseBody(
        data: widget.prod,
      ),
    );
  }
}

class PurchaseBody extends StatefulWidget {
  final Product data;
  const PurchaseBody({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  _PurchaseBodyState createState() => _PurchaseBodyState();
}

class _PurchaseBodyState extends State<PurchaseBody> {
  int skuid = 0;
  List<Sku> sku = [];
  int skuval = 0;
  final TextEditingController quantity = TextEditingController();
  final TextEditingController yourPrice = TextEditingController();
  @override
  void initState() {
    super.initState();
    quantity.text = "0";
    getSku();
  }

  checkIsDouble(String data) {
    try {
      quantity.text = (int.parse(data)).toString();
    } catch (e) {
      quantity.text = "0";
    }
  }

  getSku() {
    print(widget.data.sku.length);
    for (dynamic res in widget.data.sku) {
      int count = 0;
      for (dynamic r in sku) {
        if (r.skuid == res.skuid) {
          count++;
        }
      }
      if (count == 0) {
        setState(() {
          sku.add(res);
        });
      }
    }
    if (sku.length > 0) {
      setState(() {
        skuval = sku[0].skuid;
      });
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
              imageurl + "product/" + widget.data.image,
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
                "Price: INR " + widget.data.retailerPrice + "/-",
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
              widget.data.productName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder(builder: (context, snapshot) {
            if (sku.length > 0) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropDown(
                  value: skuval,
                  onChange: (val) {
                    print("skuval:$val");
                    setState(() {
                      skuval = val;
                    });
                  },
                  item: sku.map(
                    (e) {
                      return DropdownMenuItem(
                        value: e.skuid,
                        child: Text(e.name),
                      );
                    },
                  ).toList(),
                ),
              );
            } else {
              return Container();
            }
          }),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              widget.data.description ?? "",
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
              controller: yourPrice,
              borderColor: primary.withOpacity(0.6),
              fillColor: light.withOpacity(0.1),
              hint: "Your Price:",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Button(
              onPressed: () {
                if (yourPrice.text.length == 0) {
                  yourPrice.text = "NA";
                }
                Cart cart = Cart(
                  productId: widget.data.id,
                  productName: widget.data.productName,
                  quantity: int.parse(quantity.text) ?? 0,
                  yourPrice: yourPrice.text,
                  productImage: widget.data.image,
                  skuid: skuval,
                  price: widget.data.retailerPrice,
                  sku: (sku.length > 0)
                      ? sku
                          .where((e) {
                            if (e.skuid == skuval) {
                              return true;
                            } else {
                              return false;
                            }
                          })
                          .toList()[0]
                          .name
                      : "No SKU",
                );
                addToCart(cart);
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

class DropDown extends StatefulWidget {
  final int value;
  final Function(int) onChange;
  final List<DropdownMenuItem> item;
  DropDown({
    Key key,
    this.item,
    this.value,
    this.onChange,
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    if (widget.item.length > 0) {
      return DropdownButton(
        onChanged: (val) {
          widget.onChange(val);
        },
        value: widget.value,
        items: widget.item,
      );
    } else {
      return Container();
    }
  }
}
