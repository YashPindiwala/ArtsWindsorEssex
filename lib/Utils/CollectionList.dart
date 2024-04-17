import 'package:flutter/material.dart';
import 'package:artswindsoressex/Utils/CollectionCard.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';
import 'package:artswindsoressex/Database/ArtworkScanned.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/constants.dart';

/// Widget for displaying a list of collection items.
class CollectionList extends StatefulWidget {
  final List<ArtworkScanned> artworks;

  const CollectionList({Key? key, required this.artworks}) : super(key: key);

  @override
  State<CollectionList> createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.15,
      ),
      itemBuilder: (context, index) {
        ArtworkScanned artwork = widget.artworks[index];
        return InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () {
            Provider.of<ArtworkProvider>(context, listen: false)
                .fetchSingleArtwork(
                    widget.artworks[index].artworkId.toString());
            Navigator.pushNamed(context, DetailScreen.id);
          },
          child: CollectionCard(
            artName: artwork.title,
            image: artwork.imageUrl,
            artNameColor: artwork.titleColor,
            cardColor: artwork.cardColor,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
      itemCount: widget.artworks.length,
    );
  }
}
