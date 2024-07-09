import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permissions/services/location_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  LocationData? myLocation;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await LocationServices.fetchCurrentLocation();

      LocationServices.fetchLiveLocation().listen((location) {
        setState(() {
          myLocation = location;
        });
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final myLocation = LocationServices.currentLocation;
    print(myLocation);
    return Scaffold(
      body: Center(
        child: Text(
          myLocation == null
              ? "Joylashuv ruxsat berilamdi"
              : "Lat : ${myLocation.latitude} va Lan: ${myLocation.longitude}",
        ),
      ),
    );
  }
}
