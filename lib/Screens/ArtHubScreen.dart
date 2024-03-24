import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Utils/GridViewStaggered.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/Utils/GridLoadingShimmer.dart';
import 'package:artswindsoressex/Utils/ListViewShimmerHZ.dart';
import 'package:artswindsoressex/Utils/TagsView.dart';
import 'package:artswindsoressex/API/ArtworkRequest.dart';
import 'package:artswindsoressex/API/TagRequest.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtHubProvider.dart';

class ArtHubScreen extends StatefulWidget {
  static const id = "ArtHubScreen";

  const ArtHubScreen({super.key});

  @override
  State<ArtHubScreen> createState() => _ArtHubScreenState();
}

class _ArtHubScreenState extends State<ArtHubScreen> {

  late Future _allArtworks, _allTags;

  @override
  void initState() {
    super.initState();
    _fetchAllArtworks();
    _fetchAllTags();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            children: [
              Row(
                children: [
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AboutApp.id);
                    },
                    icon: const Icon(Icons.info_outline_rounded),
                  ),
                ],
              ),
              Text(
                "Look Again! Outside: St. Clair College Art Hub",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              FutureBuilder(
                future: _allTags,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListViewShimmerHZ(); // Show loading indicator while waiting for data
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<TagModel> tags = TagModel.listFromJson(
                          snapshot.data);
                      return TagsView(tags: tags); // Show data if available
                    } else {
                      return Text(
                          "No Data"); // Show message if no data is available
                    }
                  } else {
                    return CircularProgressIndicator(); // Show a generic loading indicator for other connection states
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Consumer<ArtHubProvider>(
                    builder: (context, artHubProvider, child) {
                      List<ArtworkModel> details = artHubProvider.artHub;
                      if (!artHubProvider.loaded) {
                        return Center(
                          child: GridLoadingShimmer(),
                        );
                      } else {
                        return RefreshIndicator(
                          displacement: 10,
                          child: GridViewStaggered(artworks: details),
                          onRefresh: () async {
                            Provider.of<ArtHubProvider>(context, listen: false).fetchArtHub();
                          },
                        );// Show data if available
                      }
                    },
                  ),
              ),
            ],
          ),
        )
    );
  }

  //Methods
  _fetchAllArtworks() async {
    _allArtworks = ArtworkRequest.getAllArtworks();
  }

  _fetchAllTags() async {
    _allTags = TagRequest.getAllTags();
  }
}
