import 'package:artswindsoressex/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(42.24656086052182, -83.01904262309124),
    zoom: 17.0,
  );

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String locationName = "St. Clair College";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            initialCameraPosition: HomeScreen._initialCameraPosition,
          ),
          Positioned(
            top: 50.0,
            left: 50.0,
            right: 50.0,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.75),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                locationName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: size16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
