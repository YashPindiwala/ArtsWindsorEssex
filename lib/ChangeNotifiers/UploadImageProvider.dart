import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

class UploadImageProvider extends ChangeNotifier {
  XFile? _image;
  XFile? get image => _image;

  void setImage(XFile imageFile) {
    _image = imageFile;
    notifyListeners();
  }

  void clearImage() {
    _image = null;
    notifyListeners();
  }
}
