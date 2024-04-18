import 'package:flutter/material.dart'; // Importing material package
import 'package:artswindsoressex/Screens/Models/UploadModel.dart'; // Importing UploadModel
import 'package:cached_network_image/cached_network_image.dart'; // Importing cached_network_image package

class UserUploadList extends StatefulWidget {
  final List<UploadModel> uploads; // List of upload models
  const UserUploadList({Key? key, required this.uploads});

  @override
  State<UserUploadList> createState() => _UserUploadListState();
}

class _UserUploadListState extends State<UserUploadList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height *
          0.13, // Set the height of the list view
      child: ListView.separated(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: AspectRatio(
              aspectRatio: 4 / 4, // Aspect ratio of the image
              child: CachedNetworkImage(
                imageUrl: widget
                    .uploads[index].image, // Image URL from the upload model
                fit: BoxFit.fill, // Fill the available space
                errorWidget: (context, url, error) => Image.asset(
                    "assets/awe_logo.png"), // Error widget for image loading failures
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10); // Separator width between images
        },
        itemCount: widget.uploads.length, // Total number of uploads
      ),
    );
  }
}
