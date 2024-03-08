import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:artswindsoressex/Screens/AboutApp.dart';
import 'package:artswindsoressex/Screens/CollectionList.dart';

class CollectionScreen extends StatefulWidget {
  static const id = "CollectionScreen";
  const CollectionScreen({super.key});

  @override
  State<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {

  String _heading = "Look Again! Outside St Clair College";
  List<Map<String, dynamic>> _tags = [
    {"tag":"Cubism", "active" : true},
    {"tag":"Surrealism", "active" :false},
    {"tag":"Pop Art", "active" : false},
    {"tag":"Romanticism", "active" :false},
    {"tag":"Impressionism", "active" :false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 25,horizontal: 25),
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
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)
                ),
                height: MediaQuery.of(context).size.height * 0.06,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return TextButton(
                          onPressed: () {
                            setState(() {
                              _tags.forEach((element) {
                                element["active"] = false;
                              });
                              _tags[index]["active"] = !_tags[index]["active"];
                            });
                          },
                          child: Text(
                              _tags[index]["tag"],
                              style: _tags[index]["active"] ? null : TextStyle(
                                  color: textColor
                              )
                          )
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 10,);
                    },
                    itemCount: _tags.length
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                  child: CollectionList(),
              )
            ],
          ),
        )
      );
  }
}
