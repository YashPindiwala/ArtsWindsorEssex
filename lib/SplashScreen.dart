import 'package:flutter/material.dart'; // Importing material package
import 'package:flutter_svg/flutter_svg.dart'; // Importing flutter_svg package
import 'package:artswindsoressex/Screens/Navigation.dart'; // Importing Navigation screen
import 'package:artswindsoressex/ChangeNotifiers/EventProvider.dart'; // Importing EventProvider
import 'package:artswindsoressex/ChangeNotifiers/ArtHubProvider.dart'; // Importing ArtHubProvider
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart'; // Importing TagProvider
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart'; // Importing ArtworkProvider
import 'package:provider/provider.dart'; // Importing provider package
import 'package:artswindsoressex/Database/DatabaseHelper.dart'; // Importing DatabaseHelper

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen'; // Defining id for SplashScreen
  const SplashScreen({super.key}); // Constructor for SplashScreen

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState(); // Creating state for SplashScreen
}

class _SplashScreenState extends State<SplashScreen> {
  double position = -320; // Initial position for animation
  double logo = 0.0; // Initial opacity for logo
  String change = "Change happens here."; // Initial message

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final Size screenSize = MediaQuery.of(context).size;
      Future.delayed(Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            position =
                screenSize.height * 0.00; // Updating position for animation
            logo = 1.0; // Updating opacity for logo
          });
        }
      });
      DatabaseHelper().database; // Initializing database
      Provider.of<ArtworkProvider>(context, listen: false)
          .fetchArtwork(); // Fetching artwork data
      Provider.of<EventProvider>(context, listen: false)
          .fetchCurrEvents(); // Fetching current events data
      Provider.of<EventProvider>(context, listen: false)
          .fetchPastEvents(); // Fetching past events data
      Provider.of<ArtHubProvider>(context, listen: false)
          .fetchArtHub(); // Fetching art hub data
      Provider.of<TagProvider>(context, listen: false)
          .fetchTags(); // Fetching tags data
      Future.delayed(
          Duration(milliseconds: 2500),
          () => Navigator.popAndPushNamed(
              context,
              Navigation
                  .id)); // Navigating to the navigation screen after delay
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size; // Getting screen size
    return Scaffold(
        body: Stack(
      children: [
        AnimatedPositioned(
            left: screenSize.width * 0.1,
            top: position,
            child: SvgPicture.asset(
              "assets/top_graphic.svg",
              height: screenSize.height * 0.4,
            ), // Using SVG image for animation
            duration: Duration(milliseconds: 1500)),
        Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimatedOpacity(
              duration: Duration(milliseconds: 1500),
              opacity: logo,
              child: Image.asset('assets/awe_logo.png',
                  height: screenSize.height *
                      0.25), // Using logo image with animation
            )
            // Text(change)
          ],
        )),
        AnimatedPositioned(
            right: screenSize.width * 0.1,
            bottom: position,
            child: SvgPicture.asset("assets/bottom_graphic.svg",
                height:
                    screenSize.height * 0.4), // Using SVG image for animation
            duration: Duration(milliseconds: 1500)),
      ],
    ));
  }
}
