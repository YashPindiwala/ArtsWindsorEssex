import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/constants.dart';

class TagsView extends StatefulWidget {
  const TagsView({super.key,required this.tags});
  final List<TagModel> tags;

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = List.filled(widget.tags.length, false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(25)),
        height: MediaQuery.of(context).size.height * 0.06,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ToggleButtons(
            children: widget.tags
                .map((tag) {
              int index = widget.tags.indexOf(tag);
              print("Index: $index, Selected: ${_isSelected[index]}"); // Debugging print
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(tag.tag,),
              );
            }).toList(),
            isSelected: _isSelected,
            onPressed: (index) {
              print("Pressed Index: $index"); // Debugging print
              setState(() {
                for (int i = 0; i < _isSelected.length; i++) {
                  _isSelected[i] = false; // Deselect all buttons
                }
                _isSelected[index] = !_isSelected[index];
              });
            },
            selectedColor: orangeColor,
            fillColor: Colors.transparent,
            splashColor: Colors.transparent,
            renderBorder: false,
          ),
        ),
    );
  }
}
