import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      itemCount: widget.artworks.length,
      itemBuilder: (context, index) {
        return Container(
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
        );
      },
    );
  }
}
