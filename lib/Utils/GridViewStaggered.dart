import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';

class GridViewStaggered extends StatefulWidget {
  const GridViewStaggered({super.key,required this.artworks});
  final List<ArtworkModel> artworks;

  @override
  State<GridViewStaggered> createState() => _GridViewStaggeredState();
}

class _GridViewStaggeredState extends State<GridViewStaggered> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.15),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      itemCount: widget.artworks.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Provider.of<ArtworkProvider>(context, listen: false).fetchSingleArtwork(widget.artworks[index].artwork_id.toString());
            Navigator.pushNamed(context, DetailScreen.id);
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl: widget.artworks[index].image,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/awe_logo.png",
                  )
              ),
            ),
          ),
        );
      },
    );
  }
}
