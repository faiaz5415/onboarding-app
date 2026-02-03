import 'package:flutter/material.dart';
import '../helpers/permission_helper.dart';

class LocationProvider extends ChangeNotifier {
  bool _isAllowed = false;
  String _locationText = '';

  bool get isAllowed => _isAllowed;
  String get locationText => _locationText;

  Future<void> requestLocation() async {
    final allowed = await PermissionHelper.requestLocationPermission();

    if (!allowed) {
      _isAllowed = false;
      notifyListeners();
      return;
    }

    _isAllowed = true;
    _locationText = 'Selected Location';
    notifyListeners();
  }
}
