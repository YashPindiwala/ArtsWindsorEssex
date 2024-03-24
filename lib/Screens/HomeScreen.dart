import 'dart:io';
import 'package:artswindsoressex/Screens/Models/LocationModel.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'AboutApp.dart';
import 'package:card_loading/card_loading.dart';
import 'package:artswindsoressex/API/ArtworkRequest.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';

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
  late PermissionStatus locationPermission;
  String locationName = "St. Clair College";
  late GoogleMapController _googleMapController;
  late Future _getNonDigitalArt;
  bool showMap = false;

  @override
  void initState() {
    super.initState();
    _fetchNonDigitalArt();
    askForPermission();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Consumer<ArtworkProvider>(
            builder: (context, artworkProvider, child) {
              List<ArtworkModel> list = artworkProvider.artworks;
              List<LocationDetails> locations = [];
              for (var artwork in list) {
                locations.add(artwork.location);
              }
              if(!artworkProvider.loaded){
                return CardLoading(
                  height: MediaQuery.of(context).size.height
                );
              } else {
                return GoogleMap(
                    mapToolbarEnabled: false,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: HomeScreen._initialCameraPosition,
                    onMapCreated: (controller) =>
                    _googleMapController = controller,
                    markers: Set<Marker>.from(locations.map(
                          (location) => Marker(
                        markerId: MarkerId(location.title!),
                        position: LatLng(double.parse(location.latitude!),
                            double.parse(location.longitude!)),
                        infoWindow: InfoWindow(title: location.title!),
                      ),
                    ))); // Show data if available
              }
            },
          ),
          Positioned(
            top: 70.0,
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
          Container(
            padding: EdgeInsets.all(25),
            child: Row(
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
          )
        ],
      ),
      floatingActionButton: Container(
        padding: EdgeInsets.only(bottom: 75, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            // Animate the map to the initial camera position
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(HomeScreen._initialCameraPosition),
            );
          },
          backgroundColor:
              orangeColor.withOpacity(0.90), // Change the background color
          child: const Icon(Icons.my_location_rounded, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _fetchNonDigitalArt() async {
    _getNonDigitalArt = ArtworkRequest.getAllNonDigitalArtwork();
  }

  askForPermission() async {
    locationPermission = await Permission.locationWhenInUse.request();

    if (locationPermission.isGranted) {
      _fetchNonDigitalArt();
    } else if (locationPermission.isDenied) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Permission Required"),
            content: Text(
                "To proceed, please grant location permission. If denied, the app will close."),
            actions: [
              TextButton(
                onPressed: () {
                  exit(0); // Close dialog and exit app
                },
                child: Text("Deny"),
              ),
              TextButton(
                onPressed: () async {
                  // Request permission again
                  PermissionStatus status =
                      await Permission.locationWhenInUse.request();
                  if (status.isGranted) {
                    Navigator.of(context).pop(); // Close outer dialog
                    _fetchNonDigitalArt();
                  } else {
                    // Handle if permission is still denied
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Permission Denied"),
                          content: Text(
                              "Without location permission, the app cannot proceed."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).popUntil((route) =>
                                    route.isFirst); // Close all dialogs
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("Grant Permission"),
              ),
            ],
          );
        },
      );
    }
  }
}
