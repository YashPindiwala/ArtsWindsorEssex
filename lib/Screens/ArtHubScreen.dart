import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Utils/GridViewStaggered.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/Utils/GridLoadingShimmer.dart';
import 'package:artswindsoressex/API/ArtworkRequest.dart';

class ArtHubScreen extends StatefulWidget {
  static const id = "ArtHubScreen";

  const ArtHubScreen({super.key});

  @override
  State<ArtHubScreen> createState() => _ArtHubScreenState();
}

class _ArtHubScreenState extends State<ArtHubScreen> {

  List<Map<String, dynamic>> listOfMaps = [
    {"tag": "Cubism", "active": false},
    {"tag": "Surrealism", "active": false},
    {"tag": "Pop Art", "active": false},
    {"tag": "Romanticism", "active": false},
    {"tag": "Impressionism", "active": false},
  ];

  late Future _allArtworks;

  @override
  void initState() {
    super.initState();
    _fetchAllArtworks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          padding: EdgeInsets.only(top: 25,left: 25,right: 25),
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.06,
                child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                Colors.transparent),
                            enableFeedback: false,
                          ),
                          onPressed: () {
                            setState(() {
                              listOfMaps.forEach((element) {
                                element["active"] = false;
                              });
                              listOfMaps[index]["active"] =
                              !listOfMaps[index]["active"];
                            });
                          },
                          child: Text(
                              listOfMaps[index]["tag"],
                              style: listOfMaps[index]["active"]
                                  ? null
                                  : TextStyle(
                                  color: textColor
                              )
                          )
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10,);
                    },
                    itemCount: listOfMaps.length
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: FutureBuilder(
                    future: _allArtworks,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return GridLoadingShimmer(); // Show loading indicator while waiting for data
                      } else
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          List<ArtworkModel> artworks = ArtworkModel
                              .listFromJson(snapshot.data);
                          return RefreshIndicator(
                            displacement: 10,
                            child: GridViewStaggered(artworks: artworks),
                            onRefresh: () async {
                              _fetchAllArtworks();
                              setState(() {});
                            },
                          ); // Show data if available
                        } else {
                          return Text(
                              "No Data"); // Show message if no data is available
                        }
                      } else {
                        return CircularProgressIndicator(); // Show a generic loading indicator for other connection states
                      }
                    },
                  )
              )
            ],
          ),
        )
    );
  }

  //Methods
  _fetchAllArtworks() async {
    _allArtworks = ArtworkRequest.getAllArtworks();
  }
}
