import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart'; // Importing flutter_staggered_grid_view package
import 'package:flutter/material.dart'; // Importing material package
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart'; // Importing ArtworkModel
import 'package:cached_network_image/cached_network_image.dart'; // Importing cached_network_image package
import 'package:artswindsoressex/Screens/DetailScreen.dart'; // Importing DetailScreen
import 'package:provider/provider.dart'; // Importing provider package
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart'; // Importing ArtworkProvider

class GridViewStaggered extends StatefulWidget {
  const GridViewStaggered({Key? key, required this.artworks});
  final List<ArtworkModel> artworks; // List of artwork models

  @override
  State<GridViewStaggered> createState() => _GridViewStaggeredState();
}

class _GridViewStaggeredState extends State<GridViewStaggered> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height *
              0.15), // Padding at the bottom
      crossAxisCount: 2, // Number of columns
      crossAxisSpacing: 10, // Spacing between columns
      mainAxisSpacing: 12, // Spacing between rows
      shrinkWrap: true,
      itemCount: widget.artworks.length, // Total number of artworks
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Provider.of<ArtworkProvider>(context, listen: false)
                .fetchSingleArtwork(widget.artworks[index].artwork_id
                    .toString()); // Fetch single artwork when tapped
            Navigator.pushNamed(
                context, DetailScreen.id); // Navigate to detail screen
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(25)), // Rounded border decoration
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(15), // ClipRRect with rounded border
              child: CachedNetworkImage(
                  imageUrl: widget
                      .artworks[index].image, // Image URL from artwork model
                  fit: BoxFit.fill, // Fill the available space
                  errorWidget: (context, url, error) => Image.asset(
                        // Error widget for image loading failures
                        "assets/awe_logo.png",
                      )),
            ),
          ),
        );
      },
    );
  }
}
