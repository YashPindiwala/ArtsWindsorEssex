import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'AboutApp.dart';
import 'package:artswindsoressex/Screens/forms/CommentForm.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/Screens/Models/ArtworkModel.dart';
import 'package:artswindsoressex/Screens/Models/TagModel.dart';
import 'package:artswindsoressex/Screens/Models/CommentModel.dart';
import 'package:artswindsoressex/Utils/DetailLoadingShimer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:artswindsoressex/API/CommentRequest.dart';
import 'package:artswindsoressex/Utils/ListViewShimmerHZ.dart';
import 'package:artswindsoressex/Screens/forms/UserUploadForm.dart';
import 'package:artswindsoressex/Screens/Navigation.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/NavigationProvider.dart';
import 'package:artswindsoressex/Utils/UserUploadList.dart';
import 'package:artswindsoressex/Screens/Models/UploadModel.dart';

class DetailScreen extends StatefulWidget {
  static const id = "DetailScreen";

  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _heroTag = "collection";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            if (Provider.of<NavigationProvider>(context, listen: false)
                    .currentIndex ==
                0) {
              Provider.of<NavigationProvider>(context, listen: false)
                  .navigate(2);
              Navigator.pushReplacementNamed(context, Navigation.id);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Consumer<ArtworkProvider>(
            builder: (context, value, child) {
              if (!value.loaded) {
                return DetailLoadingShimmer();
              } else {
                ArtworkModel artwork = value.artwork;
                List<TagModel> tag = artwork.tags;
                List<UploadModel> uploads = artwork.uploads.where((element) => element.visible == true && element.approved == true).toList();
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
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        "assets/awe_logo.png",
                                      )))),
                    ),
                    SizedBox(
                      height: 20,
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
                          onPressed:
                              artwork.is_digital || artwork.upload_disabled
                                  ? null
                                  : () {
                                      Navigator.pushNamed(
                                          context, UserUploadForm.id,
                                          arguments: {"artwork": artwork});
                                    },
                          child: Text("Upload Art"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
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
                    Visibility(
                        visible: uploads.isNotEmpty,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Related Art",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            UserUploadList(uploads: uploads,),
                          ],
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FilledButton(
                      onPressed: artwork.comments_disabled
                          ? () {
                              Navigator.pushNamed(context, CommentForm.id,
                                  arguments: {
                                    "artwork_id": artwork.artwork_id
                                  });
                            }
                          : null,
                      child: Text("Add Comment"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: true,
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
                          FutureBuilder<List<CommentModel>>(
                              future: CommentRequest.getRelatedComments(
                                  artwork.artwork_id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (snapshot.hasData) {
                                  List<CommentModel> comments = snapshot.data!;
                                  if (comments.isEmpty) {
                                    return Text(
                                      "No comments yet!.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    );
                                  }
                                  comments = comments
                                      .where(
                                          (element) => element.visible == true)
                                      .toList();
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        CommentModel comment = comments[index];
                                        return Text(
                                          comment.comment,
                                          // Use actual comment text
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return Divider(thickness: 0.2);
                                      },
                                      itemCount: comments
                                          .length, // Set item count based on comments
                                    ),
                                  );
                                } else {
                                  // Handle loading state (optional)
                                  return ListViewShimmerHZ();
                                }
                              },
                          ),
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
