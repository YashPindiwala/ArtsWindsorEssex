import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Utils/GridLoadingShimmer.dart';

class ArtHubScreen extends StatefulWidget {
  static const id = "ArtHubScreen";
  const ArtHubScreen({super.key});

  @override
  State<ArtHubScreen> createState() => _ArtHubScreenState();
}

class _ArtHubScreenState extends State<ArtHubScreen> {

  List<Map<String, dynamic>> listOfMaps = [
    {"tag":"Cubism", "active" : false},
    {"tag":"Surrealism", "active" :false},
    {"tag":"Pop Art", "active" : false},
    {"tag":"Romanticism", "active" :false},
    {"tag":"Impressionism", "active" :false},
  ];

  List<String> image = [
    "assets/image1.png",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.png",
    "assets/image5.png",
    "assets/image1.png",
    "assets/image2.png",
    "assets/image3.png",
    "assets/image4.png",
    "assets/image5.png",
  ];

  final List<int> _itemHeights = [150, 100, 200, 120, 180, 150, 100, 220, 160];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
          padding: EdgeInsets.all(25),
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
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25)
                ),
                height: MediaQuery.of(context).size.height * 0.06,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TextButton(
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(Colors.transparent),
                            enableFeedback: false,
                          ),
                          onPressed: () {
                            setState(() {
                              listOfMaps.forEach((element) {
                                element["active"] = false;
                              });
                              listOfMaps[index]["active"] = !listOfMaps[index]["active"];
                            });
                          },
                          child: Text(
                            listOfMaps[index]["tag"],
                            style: listOfMaps[index]["active"] ? null : TextStyle(
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
                  future: Future.delayed(Duration(seconds: 5)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return GridLoadingShimmer(); // Show loading indicator while waiting for data
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        return Text("Data available");// Show data if available
                      } else {
                        return MasonryGridView.count(
                          padding: EdgeInsets.only(bottom: 100),
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          shrinkWrap: true,
                          itemCount: image.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(image[index],fit: BoxFit.fill,),
                              ),
                            );
                          },
                        );// Show message if no data is available
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
}
