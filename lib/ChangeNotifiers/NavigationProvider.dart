import 'package:flutter/material.dart'; // Importing Flutter material library

class NavigationProvider extends ChangeNotifier {
  int _currentIndex = 2; // Initial value for the current index
  int get currentIndex => _currentIndex; // Getter for the current index

  // Method to update the current index and notify listeners
  navigate(int index) {
    _currentIndex = index; // Update the current index with the provided value
    notifyListeners(); // Notify listeners of the change
  }
}
