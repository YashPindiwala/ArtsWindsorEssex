import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Screens/CollectionScreen.dart';
import 'package:artswindsoressex/Screens/ArtHubScreen.dart';
import 'package:artswindsoressex/Screens/CurrentEvents.dart';
import 'package:artswindsoressex/Screens/QRCodeScreen.dart';
import 'package:artswindsoressex/Screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/NavigationProvider.dart';

// This widget defines the main navigation structure of the app,
// including a bottom navigation bar and different screens that
// can be navigated to. It uses the Provider package to manage
// the state of the current screen index and displays the
// corresponding screen based on the selected index.
class Navigation extends StatefulWidget {
  // Unique identifier for this widget
  static const id = "Navigation";

  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  // List of screens to be displayed in the bottom navigation bar
  List<Widget> _screens = [
    QrScannerScreen(),
    CollectionScreen(),
    HomeScreen(),
    ArtHubScreen(),
    CurrentEvents()
  ];

  @override
  Widget build(BuildContext context) {
    // Build method for the Navigation widget
    return Scaffold(
      // Scaffold widget for the main app structure
      body: Stack(
        // Stack widget to allow for overlapping widgets
        children: [
          // Main content of the app
          Center(
            child: _screens.elementAt(
                Provider.of<NavigationProvider>(context).currentIndex),
          ),
          // Floating navigation bar at the bottom of the screen
          Positioned(
            left: 10,
            right: 10,
            bottom: 0,
            child: Theme(
              // Theme widget to customize the appearance of the navigation bar
              data: Theme.of(context)
                  .copyWith(splashColor: Colors.transparent),
              child: BottomAppBar(
                // BottomAppBar widget for the navigation bar
                color: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                child: ClipRRect(
                  // ClipRRect widget to clip the navigation bar's edges
                  borderRadius: BorderRadius.circular(50),
                  child: BottomNavigationBar(
                    // BottomNavigationBar widget for the navigation items
                    enableFeedback: false,
                    currentIndex: Provider.of<NavigationProvider>(context)
                        .currentIndex,
                    iconSize: 26,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: orangeColor.withOpacity(0.90),
                    showSelectedLabels: false,
                    selectedFontSize: 0.0,
                    unselectedFontSize: 0.0,
                    showUnselectedLabels: false,
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white.withOpacity(0.65),
                    items: [
                      // Navigation items for each screen
                      BottomNavigationBarItem(
                        icon: Icon(Icons.qr_code_2),
                        label: "Qr",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.image),
                        label: "Collection",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.map),
                        label: "Map",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.dashboard),
                        label: "Art_Hub",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.event),
                        label: "Event",
                      ),
                    ],
                    onTap: (value) {
                      // Handle navigation item taps
                      if (value != 0)
                        Provider.of<NavigationProvider>(context, listen: false)
                            .navigate(value);
                      else
                        showDialog(
                          context: context,
                          builder: (context) => _disabledDialog(),
                        );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// Dialog to inform the user that certain screens are not accessible
// without being in the proximity of an artwork. Currently disabled.
Widget _disabledDialog() {
  return AlertDialog(
    title: Text(
      "No access.",
      style: Theme.of(context).textTheme.headlineLarge,
    ),
    content: Text(
      "You cannot navigate to this screen unless in the proximity of an artwork.",
      style: Theme.of(context).textTheme.headlineMedium,
    ),
  );
}
}
