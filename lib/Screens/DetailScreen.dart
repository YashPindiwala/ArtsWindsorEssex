import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'AboutApp.dart';

class DetailScreen extends StatefulWidget {
  static const id = "DetailScreen";
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String _artist = "John Kissick";
  String _title = "JI Feel Better (than James Brown)";
  String _description= "Is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.";
  String _imagePath = "assets/exampledetail.jpg";
  List<String> _tags = ["Abstract", "Pop"];
  bool _isCommentVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25,vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  _artist,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  _title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: AspectRatio(
                      aspectRatio: 2/2,
                      child: Image.asset(_imagePath, fit: BoxFit.fill,),
                  )
                ),
                SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  Text(
                      _tags[0],
                      style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: 10,),
                  Text(
                      _tags[1],
                      style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Spacer(),
                  FilledButton(
                    onPressed: () {},
                    child: Text("Upload Art"),
                  ),
                ],
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  _description,
                  style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: 10,
              ),
              Visibility(
                visible: _isCommentVisible,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FilledButton(
                        onPressed: () {

                        },
                        child: Text(
                            "Add Comment"
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Comments",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 300,
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Text(
                                "Is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.",
                                style: Theme.of(context).textTheme.headlineMedium,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(thickness: 0.2);
                            },
                            itemCount: 10
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}
