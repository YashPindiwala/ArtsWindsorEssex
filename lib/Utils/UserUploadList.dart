import 'package:flutter/material.dart';
import 'package:artswindsoressex/Screens/Models/UploadModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UserUploadList extends StatefulWidget {
  final List<UploadModel> uploads;
  const UserUploadList({super.key, required this.uploads});

  @override
  State<UserUploadList> createState() => _UserUploadListState();
}

class _UserUploadListState extends State<UserUploadList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery
          .of(context)
          .size
          .height * 0.13,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => _imageDialog(widget.uploads[index]),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: CachedNetworkImage(
                      imageUrl: widget.uploads[index].image,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/awe_logo.png",)
                  )
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
        itemCount: widget.uploads.length,
      ),
    );
  }

  _imageDialog(UploadModel upload) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                upload.title,
                style: Theme.of(context).textTheme.headline6,
                softWrap: true,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: CachedNetworkImage(
                  imageUrl: upload.image,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/awe_logo.png"),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}