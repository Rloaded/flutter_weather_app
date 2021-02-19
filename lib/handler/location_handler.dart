import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

enum LocationStatus {
  noPermissionForever,
  noService,
  fine,
}

/// Händelt alle Anfragen bezüglich Benutzerposition, die Berechtigungen dafür 
/// und das Zuweisen von Koordianten zu Städtenamen.
class LocationHandler {

  /// Prüft ob die App die Berechtigigung hat auf den Benutzerstandort zuzugreifen.
  /// Außerdem prüft sie ob GPS aktiv ist. Returned [LocationStatus.noService].
  /// Sollte die App keine Berechtigungen haben fordert sie sie an.
  /// Returned [LocationStatus.noPermissionForever] falls der Benutzer der App die 
  /// Rechte permanent entzieht.
  static Future<bool> hasPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(LocationStatus.noService);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(LocationStatus.noPermissionForever);
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.value(false);
      }
    }

    return Future.value(true);
  }

  /// Frägt die aktuelle Position ab.
  static Future<Position> getPosition() {
    return Geolocator.getCurrentPosition();
  }

  /// Ordnet [position] den entsprechenden Städtenamen zu.
  static Future<String> getCityName(Position position) async {
    final adress =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    return adress.first.locality;
  }
}
