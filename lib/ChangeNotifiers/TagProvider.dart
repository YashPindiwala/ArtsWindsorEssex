import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/API/TagRequest.dart';

class TagProvider extends ChangeNotifier {
  static TagModel noSelection = TagModel(tag: "",id: 0);
  List<TagModel> _tags = [];
  List<TagModel> get tags => _tags;

  TagModel? _selectedTag;
  TagModel? get selectedTag => _selectedTag;

  List<bool> _selectedTagsBool = [];
  List<bool> get selectedTagsBool => _selectedTagsBool;

  List<TagModel> _selectedTags = [];
  List<TagModel> get selectedTags => _selectedTags;

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
      _selectedTagsBool = List.generate(_tags.length, (index) => false);
    } catch (e) {
      // Handle error
      print('Error fetching tags: $e');
    } finally {
      notifyListeners();
    }
  }

  void selectTag(TagModel tag) {
    _selectedTag = tag;
    notifyListeners();
  }

  void updateTagsList(int index, bool value) {
    _selectedTagsBool[index] = value;
    _selectedTags = _tags.asMap().entries.where((entry) => _selectedTagsBool[entry.key]).map((entry) => entry.value).toList();
    notifyListeners();
  }

  void clearSelectedTags(){
    _selectedTagsBool = List.generate(_tags.length, (index) => false);
    _selectedTags = [];
    notifyListeners();
  }

}
