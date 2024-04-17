import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:cross_file/cross_file.dart'; // Importing CrossFile for handling file uploads

class UploadImageProvider extends ChangeNotifier {
  XFile? _image; // Variable to store the uploaded image file
  XFile? get image => _image; // Getter for the uploaded image file

  // Method to set the uploaded image file
  void setImage(XFile imageFile) {
    _image = imageFile; // Assign the provided image file to _image
    notifyListeners(); // Notify listeners of data change
  }

  // Method to clear the uploaded image file
  void clearImage() {
    _image = null; // Clear the uploaded image file
    notifyListeners(); // Notify listeners of data change
  }
}
