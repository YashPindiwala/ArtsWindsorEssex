class LocationDetails {
  final String title;
  final String latitude;
  final String longitude;

  LocationDetails.empty()
      : title = 'Unknown',
        latitude = '0.0',
        longitude = '0.0';

  LocationDetails({
    required this.title,
    required this.latitude,
    required this.longitude,
  });
}
