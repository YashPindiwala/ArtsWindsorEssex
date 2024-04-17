import 'package:flutter/material.dart'; // Importing Flutter material library
import 'package:artswindsoressex/Screens/Models/TagModel.dart'; // Importing TagModel class for tag data
import 'package:artswindsoressex/API/TagRequest.dart'; // Importing TagRequest class for API requests

class TagProvider extends ChangeNotifier {
  static TagModel noSelection =
      TagModel(tag: "", id: 0); // Placeholder for no selection

  List<TagModel> _tags = []; // List to store tags
  List<TagModel> get tags => _tags; // Getter for tags list

  TagModel? _selectedTag; // Currently selected tag
  TagModel? get selectedTag => _selectedTag; // Getter for selected tag

  List<bool> _selectedTagsBool =
      []; // List to track selected tags with boolean values
  List<bool> get selectedTagsBool =>
      _selectedTagsBool; // Getter for selected tags boolean list

  List<TagModel> _selectedTags = []; // List to store selected tags
  List<TagModel> get selectedTags =>
      _selectedTags; // Getter for selected tags list

  bool _loaded = false; // Flag to indicate if data is loaded
  bool get loaded => _loaded; // Getter for data load status

  // Constructor
  TagProvider() {
    _loaded = false; // Initialize data load status
    _selectedTag = null; // Initialize selected tag
  }

  // Method to fetch tags from the API
  Future<void> fetchTags() async {
    try {
      _loaded = false; // Set data load status to false
      notifyListeners(); // Notify listeners of data change
      _tags = await TagRequest.getAllTags(); // Fetch tags using API request
      _loaded = true; // Set data load status to true
      _selectedTagsBool = List.generate(_tags.length,
          (index) => false); // Initialize selected tags boolean list
    } catch (e) {
      // Handle error if fetching data fails
      print('Error fetching tags: $e');
    } finally {
      notifyListeners(); // Notify listeners of data change
    }
  }

  // Method to select a tag
  void selectTag(TagModel tag) {
    _selectedTag = tag; // Set the selected tag
    notifyListeners(); // Notify listeners of data change
  }

  // Method to update the list of selected tags
  void updateTagsList(int index, bool value) {
    _selectedTagsBool[index] = value; // Update the selected tag boolean value
    // Update the list of selected tags based on boolean values
    _selectedTags = _tags
        .asMap()
        .entries
        .where((entry) => _selectedTagsBool[entry.key])
        .map((entry) => entry.value)
        .toList();
    notifyListeners(); // Notify listeners of data change
  }

  // Method to clear the list of selected tags
  void clearSelectedTags() {
    _selectedTagsBool = List.generate(
        _tags.length, (index) => false); // Reset the selected tags boolean list
    _selectedTags.clear(); // Clear the list of selected tags
    notifyListeners(); // Notify listeners of data change
  }

  // Method to select multiple tags
  void selectMultipleTag(List<TagModel> tags) {
    tags.forEach((tag) {
      int index = _tags.indexWhere((t) => t.id == tag.id);
      if (index != -1) {
        _selectedTagsBool[index] = true;
      }
    });

    // Update the list of selected tags
    _selectedTags = _tags
        .asMap()
        .entries
        .where((entry) => _selectedTagsBool[entry.key])
        .map((entry) => entry.value)
        .toList();

    notifyListeners(); // Notify listeners of data change
  }
}
