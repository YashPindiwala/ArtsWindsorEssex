import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CollectionCard extends StatefulWidget {
  final String image;
  final String artName;
  final Color artNameColor;
  final Color cardColor;
  const CollectionCard({super.key,required this.image,required this.artName,required this.cardColor, required this.artNameColor});

  @override
  State<CollectionCard> createState() => _CollectionCardState();
}

class _CollectionCardState extends State<CollectionCard> {

  String _heroTag = "collection";

  @override
  Widget build(BuildContext context) {
    String image = widget.image;
    String artName = widget.artName;
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Column(
        children: [
          Hero(
              tag: _heroTag,
              child: AspectRatio(
                aspectRatio: 3/2,
                child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fill,
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/awe_logo.png",
                    )
                ),
              )
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(15),
              color: widget.cardColor,
              child: Text(
                artName,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: widget.artNameColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
