import 'package:flutter/material.dart'; // Importing material package
import 'package:artswindsoressex/Screens/Models/TagModel.dart'; // Importing TagModel
import 'package:artswindsoressex/constants.dart'; // Importing custom constants
import 'package:provider/provider.dart'; // Importing provider package
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart'; // Importing TagProvider

class TagsView extends StatefulWidget {
  const TagsView({Key? key, required this.tags, required this.deselectAll});
  final List<TagModel> tags; // List of tag models
  final bool deselectAll; // Boolean flag to deselect all tags

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  late List<bool> _isSelected; // List to track the selected state of each tag

  @override
  void initState() {
    super.initState();
    deselectAll(); // Deselect all tags initially
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deselectAll) {
      deselectAll(); // Deselect all tags if the flag is true
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      height: MediaQuery.of(context).size.height * 0.06,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          children: widget.tags.map((tag) {
            int index = widget.tags.indexOf(tag);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                tag.tag,
                style: _isSelected[index]
                    ? Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: orangeColor)
                    : Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: textColor),
              ),
            );
          }).toList(),
          isSelected: _isSelected,
          onPressed: (index) {
            for (int i = 0; i < _isSelected.length; i++) {
              _isSelected[i] = false; // Deselect all buttons
            }
            _isSelected[index] = true; // Select the pressed button
            var tag = widget.tags[index];
            Provider.of<TagProvider>(context, listen: false)
                .selectTag(tag); // Update the selected tag in the provider
          },
          selectedColor: orangeColor,
          fillColor: Colors.transparent,
          splashColor: Colors.transparent,
          renderBorder: false,
        ),
      ),
    );
  }

  void deselectAll() {
    _isSelected = List.filled(widget.tags.length,
        false); // Initialize _isSelected list with all false values
  }
}
