import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/API/TagRequest.dart';

class TagProvider extends ChangeNotifier {
  static TagModel noSelection = TagModel(tag: "");
  List<TagModel> _tags = [];
  List<TagModel> get tags => _tags;

  TagModel? _selectedTag;
  TagModel? get selectedTag => _selectedTag;

  List<bool> _isSelected = [];
  List<bool> get isSelected => _isSelected;

  bool _loaded = false;
  bool get loaded => _loaded;

  TagProvider() {
    _loaded = false;
    _selectedTag = null;
  }

  Future<void> fetchTags() async {
    try {
      _loaded = false;
      notifyListeners();
      _tags = await TagRequest.getAllTags();
      _loaded = true;
    } catch (e) {
      // Handle error
      print('Error fetching tags: $e');
    } finally {
      _isSelected = List.filled(_tags.length, false);
      notifyListeners();
    }
  }

  void selectTag(TagModel tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  void select(int index){
    _isSelected[index] = !_isSelected[index];
    notifyListeners();
  }
}
