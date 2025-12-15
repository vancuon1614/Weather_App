import 'package:flutter/material.dart';
import '../services/location_service.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  Position? _currentPosition;

  Position? get currentPosition => _currentPosition;

  Future<void> determinePosition() async {
    try {
      _currentPosition = await _locationService.getCurrentLocation();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
