import 'package:artswindsoressex/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Screens/CollectionScreen.dart';
import 'package:artswindsoressex/Screens/ArtHubScreen.dart';
import 'package:artswindsoressex/Screens/CurrentEvents.dart';

class Navigation extends StatefulWidget {
  static const id = "Navigation";
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 2;
  List<Widget> _screens = [
    Placeholder(),
    CollectionScreen(),
    HomeScreen(),
    ArtHubScreen(),
    CurrentEvents()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content here
          Center(
            child: _screens.elementAt(_currentIndex),
          ),
          // Floating navigation bar
          Positioned(
            left: 25,
            right: 25,
            bottom: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent
                ),
                child: BottomNavigationBar(
                  enableFeedback: false,
                  currentIndex: _currentIndex,
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
                      icon: Icon(Icons.map),
                      label: "Art_Hub",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.event),
                      label: "Event",
                    ),
                  ],
                  onTap: (value) {
                    setState(() {
                      _currentIndex = value;
                    });
                  },
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}
