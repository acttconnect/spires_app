import 'dart:math';

class MapUtils {
  static double calculateDistance(
      double userLat, double userLng, double jobLat, double jobLng) {
    const double earthRadius = 6371; // Radius of the Earth in kilometers
    // Convert degrees to radians
    double userLatRad = _degreesToRadians(userLat);
    double userLngRad = _degreesToRadians(userLng);
    double jobLatRad = _degreesToRadians(jobLat);
    double jobLngRad = _degreesToRadians(jobLng);
    // Calculate the change in coordinates
    double deltaLat = jobLatRad - userLatRad;
    double deltaLng = jobLngRad - userLngRad;
    // Haversine formula
    double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
        cos(userLatRad) *
            cos(jobLatRad) *
            sin(deltaLng / 2) *
            sin(deltaLng / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    // Distance in kilometers
    double distance = earthRadius * c;
    return distance;
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}

void getJobs() {
  double userLat = 37.7749;
  double userLng = -122.4194;

  // Coordinates of jobs
  double job1Lat = 37.7750;
  double job1Lng = -122.4185;

  double job2Lat = 37.7700;
  double job2Lng = -122.4200;

  // Set the maximum allowed distance (radius) in kilometers
  double maxDistance = 1.0;

  // Calculate distances
  double distanceToJob1 =
      MapUtils.calculateDistance(userLat, userLng, job1Lat, job1Lng);
  double distanceToJob2 =
      MapUtils.calculateDistance(userLat, userLng, job2Lat, job2Lng);

  // Check if each job is within the specified radius
  if (distanceToJob1 <= maxDistance) {
    // print('Job 1 is nearby: $distanceToJob1 km');
    // Display or store information about Job 1
  }

  if (distanceToJob2 <= maxDistance) {
    // print('Job 2 is nearby: $distanceToJob2 km');
    // Display or store information about Job 2
  }
}
