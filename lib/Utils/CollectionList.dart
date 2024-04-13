import 'package:flutter/material.dart';
import 'package:artswindsoressex/Utils/CollectionCard.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';

class CollectionList extends StatefulWidget {
  final List<ArtworkModel> artworks;
  const CollectionList({super.key, required this.artworks});

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 100),
        itemBuilder: (context, index) {
          ArtworkModel  artwork = widget.artworks[index];
          return InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.pushNamed(context, DetailScreen.id,arguments: {'result' : widget.artworks[index].artwork_id.toString()});
            },
            child: CollectionCard(artName: artwork.title, image: artwork.image, artNameColor: artwork.titleColor, cardColor: artwork.cardColor,),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
        itemCount: widget.artworks.length);
  }
}
