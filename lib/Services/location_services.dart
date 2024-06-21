import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spires_app/Constants/exports.dart';

class LocationServices {
  static double latitude = 0.0;
  static double longitude = 0.0;
  static String? address;
  static final c = Get.put(MyController());

  static late StreamSubscription<Position> streamSubscription;

  static Future<void> getAddressFromLatLang(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    latitude = position.latitude;
    longitude = position.longitude;
    Placemark place = placemark[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
    c.location.value = address!;
    c.city.value = place.locality!;
    c.isLocationLoading.value = false;
  }

  static Future<void> getLocation() async {
    c.isLocationLoading.value = true;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      c.isLocationLoading.value = false;
      _showPermissionDeniedDialog();
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      getAddressFromLatLang(position);
    }
  }
}

_showPermissionDeniedDialog() {
  return Get.defaultDialog(
    title: 'Location Permission Denied',
    middleText: 'Please grant location permission to use this feature.',
    onConfirm: () => Get.back(),
    textConfirm: 'OK',
  );
}
