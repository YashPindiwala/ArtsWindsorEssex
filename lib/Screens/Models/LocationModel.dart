import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants.dart';

class LocationDetails {
  final String title; // The title of the location
  final String latitude; // The latitude coordinate of the location
  final String longitude; // The longitude coordinate of the location

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
