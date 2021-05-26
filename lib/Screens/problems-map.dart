import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quiz/Screens/problems_screen.dart';
import 'package:quiz/modules/dialog.dart';

class ProblemsMap extends StatefulWidget {
  static String routeName = '/problem-map';

  @override
  _ProblemsMapState createState() => _ProblemsMapState();
}

class _ProblemsMapState extends State<ProblemsMap> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(59.939207, 30.315374),
    zoom: 11,
  );

  bool isLoading = true;
  bool isInit = true;

  List<Marker> points = [];

  @override
  void didChangeDependencies() {
    if (isInit) {
      final FirebaseDatabase database = FirebaseDatabase(
          databaseURL:
              'https://urban-feedback-default-rtdb.europe-west1.firebasedatabase.app');

      //database.reference().child('problems');

      DatabaseReference dbRef = database.reference().child('problems');
      print('firebase connected');

      dbRef.once().then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          print(key);
          if (values['lat'] != null && values['lon'] != null) {
            points.add(Marker(
                markerId: MarkerId(key),
                position: LatLng(values['lat'], values['lon']),
                infoWindow: InfoWindow(
                  title: values['problem'],
                  onTap: () {
                    print('info window showing');
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => MapDialog(
                        widget: InfoCard.fromJson(values),
                      ),
                    );
                  },
                )));
            print('map point added');
          }
        });
        setState(() {
          isLoading = false;
        });
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Карта проблем'),
      ),
      body: isLoading
          ? SafeArea(child: Center(child: CircularProgressIndicator()))
          : GoogleMap(
              mapType: MapType.normal,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: points.toSet(),
              initialCameraPosition: _kGooglePlex,
            ),
    );
  }
}
