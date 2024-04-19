import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Screens/AboutApp.dart';
import 'package:artswindsoressex/Utils/CollectionList.dart';
import 'package:artswindsoressex/Utils/TagsView.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/Utils/ListViewShimmerHZ.dart';
import 'package:artswindsoressex/Utils/CardLoadingShimmer.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkDB.dart';

class CollectionScreen extends StatefulWidget {
  static const id = "CollectionScreen";
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  String _heading = "Look Again! Outside St Clair College";

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<ArtworkDB>(context, listen: false).fetchTagDB();
      Provider.of<ArtworkDB>(context, listen: false).fetchArtDB();
    });
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
                _heading,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(height: 10),
              Consumer<ArtworkDB>(
                builder: (context, value, child) {
                  if (!value.loaded) {
                    return ListViewShimmerHZ();
                  } else {
                    return TagsView(tags: value.tagDB, deselectAll: false, isCollection: true );
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Consumer<ArtworkDB>(
                  builder: (context, value, child) {
                    TagModel? selectedTag = value.selectedTag;
                    if(!value.loaded){
                      return CardLoadingShimmer();
                    }else{
                      if(value.artDB.isEmpty){
                        return Center(
                          child: Text(
                            "No artwork unlocked yet.",
                            style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 18),
                          ),
                        );
                      }
                      return CollectionList(artworks: value.artDB,);
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
