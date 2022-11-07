import 'package:eztransport/core/others/logger_customizations/custom_logger.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? currentLocation;
  double? latitude;
  double? longitude;
  final log = CustomLogger(className: "LocationService");

  Future<Position?> getCurrentLocation() async {
    // Test if location services are enabled.
    LocationPermission permission = await Geolocator.checkPermission();
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            Exception('Location permissions are permanently denied.'));
      }
    }
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error(Exception('Location permissions are denied.'));
    }

    currentLocation = await Geolocator.getCurrentPosition();
    log.d(
        'Latitude: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}');
    return currentLocation;
  }
}
