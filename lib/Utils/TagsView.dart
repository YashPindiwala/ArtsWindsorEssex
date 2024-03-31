import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart';

class TagsView extends StatefulWidget {
  const TagsView({super.key,required this.tags, required this.deselectAll});
  final List<TagModel> tags;
  final bool deselectAll;

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  late List<bool> _isSelected;

  @override
  void initState() {
    super.initState();
    deselectAll();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.deselectAll){
      deselectAll();
    }
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
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(tag.tag,),
              );
            }).toList(),
            isSelected: _isSelected,
            onPressed: (index) {
                for (int i = 0; i < _isSelected.length; i++) {
                  _isSelected[i] = false; // Deselect all buttons
                }
                _isSelected[index] = true; // Select the pressed button
                var tag = widget.tags[index];
                Provider.of<TagProvider>(context,listen: false).selectTag(tag);
            },
            selectedColor: orangeColor,
            fillColor: Colors.transparent,
            splashColor: Colors.transparent,
            renderBorder: false,
          ),
        ),
    );
  }
  void deselectAll(){
    _isSelected = List.filled(widget.tags.length, false);
  }
}
