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
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart';

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
    // _fetchAllArtworks();
    // _fetchAllTags();
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
              SizedBox(height: 10,),
              Consumer<TagProvider>(
                  builder: (context, tagProvider, child) {
                    List<TagModel> tags = tagProvider.tags;
                    var noSelection = tagProvider.selectedTag == TagProvider.noSelection;
                    if(!tagProvider.loaded){
                      return ListViewShimmerHZ();
                    }else {
                      return TagsView(tags: tags, deselectAll: noSelection,);
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
                        return Consumer<TagProvider>(
                          builder: (context, value, child) {
                            var matching = details.where((element) =>
                                element.tags.any((tag) => tag.tag == value.selectedTag?.tag)).toList();
                            return RefreshIndicator(
                              displacement: 10,
                              child: GridViewStaggered(
                                artworks: matching.isNotEmpty ? matching : details,
                              ),
                              onRefresh: () async {
                                Provider.of<ArtHubProvider>(context, listen: false).fetchArtHub();
                                Provider.of<TagProvider>(context, listen: false).selectTag(TagProvider.noSelection);
                              },
                            );
                          },
                        ); // Show data if available
                      }
                    },
                  ),
              ),
            ],
          ),
        )
    );
  }

  // //Methods
  // _fetchAllArtworks() async {
  //   _allArtworks = ArtworkRequest.getAllArtworks();
  // }
  //
  // _fetchAllTags() async {
  //   _allTags = TagRequest.getAllTags();
  // }
}
