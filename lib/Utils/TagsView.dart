import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';

class TagsView extends StatefulWidget {
  const TagsView({super.key,required this.tags});
  final List<TagModel> tags;

  @override
  State<TagsView> createState() => _TagsViewState();
}

class _TagsViewState extends State<TagsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      height: MediaQuery.of(context).size.height * 0.06,
      child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  enableFeedback: false,
                ),
                onPressed: () {
                  setState(() {
                    //   listOfMaps.forEach((element) {
                    //     element["active"] = false;
                    //   });
                    //   listOfMaps[index]["active"] =
                    //   !listOfMaps[index]["active"];
                  });
                },
                child: Text(
                  widget.tags[index].tag,
                  // style: listOfMaps[index]["active"]
                  //     ? null
                  //     : TextStyle(
                  //     color: textColor
                  // )
                ));
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 10,
            );
          },
          itemCount: widget.tags.length),
    );
  }
}
