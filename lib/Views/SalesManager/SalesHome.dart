import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/main.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Authmodel.dart';

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
    return Scaffold(
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
      body: Center(
        child: Text(
          "being monitor......\n" +
              latitude.toString() +
              "<>" +
              longitude.toString(),
        ),
      ),
    );
  }
}
