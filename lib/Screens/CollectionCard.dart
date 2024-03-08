import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';

class CollectionCard extends StatefulWidget {
  const CollectionCard({super.key});

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {

  String _image = "assets/exampledetail.jpg";
  String _artName = "art name goes Here";
  String _heroTag = "collection";

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Column(
        children: [
          Hero(
              tag: _heroTag,
              child: AspectRatio(
                aspectRatio: 3/2,
                child: Image.asset(
                  _image,
                  fit: BoxFit.fill,
                ),
              )
          ),
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            height: 60,
            color: mintColor,
            child: Text(
              _artName,
              style: TextStyle(
                color: purpleColor
              ),
            ),
          )
        ],
      ),
    );
  }
}
