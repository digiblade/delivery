import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  final String? email;

  LocationPage({
    Key? key,
    this.email,
  }) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firestore
            .collection("location")
            .where("email", isEqualTo: widget.email)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> ass) {
          if (ass.hasError) {
            return Text('Something went wrong');
          }

          if (ass.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ass.data.docs.map<Widget>((e) {
            return LocationMapView(
              title: e.data()['email'],
              lat: e.data()['latitude'],
              lan: e.data()['longitude'],
            );
          }).toList()[0];
        },
      ),
    );
    // return LocationMapView(
    //   title: widget.name,
    //   lat: widget.latitude,
    //   lan: widget.longitude,
    // );
  }
}

class LocationMapView extends StatefulWidget {
  final double? lat;
  final double? lan;
  LocationMapView({
    Key? key,
    this.title,
    this.lat,
    this.lan,
  }) : super(key: key);
  final String? title;
  @override
  _LocationMapViewState createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  @override
  void initState() {
    super.initState();
    markers = Set.from([]);
    updateMarkerAndCircle(widget.lat, widget.lan);
    if (_controller != null) {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          new CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(widget.lat!, widget.lan!),
            tilt: 0,
            zoom: 18.00,
          ),
        ),
      );
    }
  }

  GoogleMapController? _controller;
  BitmapDescriptor? customIcon1;
  Set<Marker>? markers;
  Marker? marker;
  Circle? circle;
  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      BitmapDescriptor.fromAssetImage(configuration, 'assets/fire.png')
          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
  }

  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/fire.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(latitude, longitude) async {
    LatLng latlng = LatLng(latitude!, longitude!);
    Uint8List imageData = await getMarker();

    setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          // rotation: newLocalData.heading!,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
        circleId: CircleId("mapmarker"),
        radius: 10,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latlng,
        fillColor: Colors.blue.withAlpha(70),
      );
    });
  }

  void getCurrentLocation(double latitude, double longitude) async {
    LatLng latlng = LatLng(latitude, longitude);
    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        new CameraPosition(
          bearing: 192.8334901395799,
          target: latlng,
          tilt: 0,
          zoom: 18.00,
        ),
      ),
    );
    updateMarkerAndCircle(latitude, longitude);
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(37.42796133580644, -122.085749655962),
    zoom: 18.00,
  );

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: initialLocation,
      markers: Set.of((marker != null) ? [marker!] : []),
      circles: Set.of((circle != null) ? [circle!] : []),
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
        _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(widget.lat!, widget.lan!),
              tilt: 0,
              zoom: 18.00,
            ),
          ),
        );
      },
    );
  }
}
