import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Screens/forms/CommentForm.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:card_loading/card_loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailScreen extends StatefulWidget {
  static const id = "DetailScreen";

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _artist = "John Kissick";
  String _title = "JI Feel Better (than James Brown)";
  String _description =
      "Is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries.";
  String _imagePath = "assets/exampledetail.jpg";
  List<String> _tags = ["Abstract", "Pop"];
  bool _isCommentVisible = true;
  String _heroTag = "collection";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String? result = args?['result'];
    Provider.of<ArtworkProvider>(context, listen: false).fetchSingleArtwork(result!);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, AboutApp.id);
          //   },
          //   icon: const Icon(Icons.info_outline_rounded),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Consumer<ArtworkProvider>(
            builder: (context, value, child) {
              if(!value.loaded){
                return CardLoading(
                  height: MediaQuery.of(context).size.height,
                );
              } else{
                ArtworkModel artwork = value.artwork;
                List<TagModel> tag = artwork.tags;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${artwork.artist.firstName} ${artwork.artist.lastName}",
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      "${artwork.title}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Hero(
                      tag: _heroTag,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: AspectRatio(
                            aspectRatio: 2 / 2,
                            child: CachedNetworkImage(
                                imageUrl: artwork.image,
                                fit: BoxFit.fill,
                                errorWidget: (context, url, error) => Image.asset("assets/awe_logo.png",)
                            )
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${tag[0].tag}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "${tag[1].tag}",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Spacer(),
                        FilledButton(
                          onPressed: artwork.upload_disabled ? () {} : null,
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
                      "${artwork.description}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FilledButton(
                      onPressed: artwork.comments_disabled ? () {
                        Navigator.pushNamed(context, CommentForm.id);
                      }: null,
                      child: Text("Add Comment"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: artwork.comments_disabled,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(thickness: 0.2);
                                },
                                itemCount: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
