import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/Components/Color.dart';
// import 'package:delivery/main.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Authmodel.dart';
import 'SMPurchase.dart';

class SMHome extends StatefulWidget {
  SMHome({Key key}) : super(key: key);

  @override
  _SMHomeState createState() => _SMHomeState();
}

class _SMHomeState extends State<SMHome> {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  // ignore: unused_field
  LocationData _locationData;
  double latitude = 120.2020;
  double longitude = 102.2020;
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  getPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  getLocationData() async {
    await getPermission();
    _locationData = await location.getLocation();
    trackLocation();
  }

  trackLocation() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("change");
      setState(() {
        latitude = currentLocation.latitude;
        longitude = currentLocation.longitude;
      });
      updateLocation(latitude, longitude);
    });
  }

  updateLocation(double latitude, double longitude) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String email = pref.getString('userid');
    print(email);
    FirebaseFirestore.instance.collection('location').doc(email).set({
      'email': email,
      'latitude': latitude,
      'longitude': longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          title: Text("Sales Manager"),
        ),
        endDrawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            logout();
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/logout',
              (route) => false,
            );
          },
          child: Icon(Icons.logout),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: ListTile(
                    tileColor: light,
                    leading: Image.asset(
                      "assets/gif/488.gif",
                    ),
                    title: Text(
                      "Being monitored",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "you are under surveillance and sharing your livelocation",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  shrinkWrap: true,
                  primary: false,
                  children: [
                    OpenContainer(
                      closedBuilder: (context, action) => ProductCard(),
                      openBuilder: (context, action) => SMpurchase(),
                    ),
                    ProductCard(),
                    ProductCard(),
                    ProductCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.network(
              "https://digiblade.in/popposapi/images/biryani.jpeg",
            ).image,
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // width: double.infinity,
                  color: primary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 12,
                    ),
                    child: Text(
                      "160/-",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: light,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // width: double.infinity,
                  color: light.withOpacity(0.8),
                  child: ListTile(
                    title: Text(
                      "Prodctname",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Text(
                      "Prodctname",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
