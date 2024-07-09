import 'dart:async';

import 'package:location/location.dart';

class LocationServices {
  static final _location = Location();

  static bool _serviceEnabled = false;
  static PermissionStatus _permissionStatus = PermissionStatus.denied;
  static LocationData? currentLocation;

  static Future<void> init() async {
    await checkService();
    if (_serviceEnabled) {
      checkPermission();
    }
  }

  static Future<void> checkService() async {
    _serviceEnabled = await _location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
  }

  static Future<void> checkPermission() async {
    _permissionStatus = await _location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await _location.requestPermission();

      if (_permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
  }

  static Future<void> fetchCurrentLocation() async {
    currentLocation = await _location.getLocation();
  }

  static Stream<LocationData> fetchLiveLocation() async* {
    yield* _location.onLocationChanged;
  }
}
