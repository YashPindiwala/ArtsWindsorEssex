import 'package:artswindsoressex/Screens/Models/LocationModel.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'AboutApp.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(42.24833109246298, -83.01939482309436),
    zoom: 16.5, //Controls how far the map view is zoomed
  );

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String locationName = "St. Clair College";
  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      home: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: HomeScreen._initialCameraPosition,
              onMapCreated: (controller) => _googleMapController = controller,
              markers: Set<Marker>.from(locations.map((location) => Marker(
                    markerId: MarkerId(location.title),
                    position: LatLng(double.parse(location.latitude),
                        double.parse(location.longitude)),
                    infoWindow: InfoWindow(title: location.title),
                  ))),
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
            Row(
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AboutApp.id);
                  },
                  icon: const Icon(Icons.info_outline_rounded),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Animate the map to the initial camera position
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(HomeScreen._initialCameraPosition),
            );
          },
          backgroundColor: Colors.white, // Change the background color
          child: const Icon(Icons.my_location_rounded), // Change the icon
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
