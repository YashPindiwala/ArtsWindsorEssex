import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/Database/DatabaseHelper.dart';

class GridViewStaggered extends StatefulWidget {
  const GridViewStaggered({super.key, required this.artworks});

  final List<ArtworkModel> artworks;

  @override
  State<GridViewStaggered> createState() => _GridViewStaggeredState();
}

class _GridViewStaggeredState extends State<GridViewStaggered> {
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.only(bottom: MediaQuery
          .of(context)
          .size
          .height * 0.15),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      itemCount: widget.artworks.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            if(widget.artworks[index].is_digital){
              Provider.of<ArtworkProvider>(context, listen: false).fetchSingleArtwork(widget.artworks[index].artwork_id.toString());
              Navigator.pushNamed(context, DetailScreen.id);
            }
            else if (await DatabaseHelper().isArtworkIdExists(widget.artworks[index].artwork_id)) {
              Provider.of<ArtworkProvider>(context, listen: false).fetchSingleArtwork(widget.artworks[index].artwork_id.toString());
              Navigator.pushNamed(context, DetailScreen.id);
            } else {
              showDialog(
                context: context,
                builder: (context) => _notUnlockedDialog(),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                  imageUrl: widget.artworks[index].image,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Image.asset(
                        "assets/awe_logo.png",
                      )
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _notUnlockedDialog() {
    return AlertDialog(
          title: Text(
            'You have not unlocked this artwork yet.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
  }

}
