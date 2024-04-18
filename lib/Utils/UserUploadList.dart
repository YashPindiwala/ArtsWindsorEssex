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
      height: MediaQuery.of(context).size.height * 0.13,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                  aspectRatio: 4 / 4,
                  child: CachedNetworkImage(
                      imageUrl: widget.uploads[index].image,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Image.asset("assets/awe_logo.png",)
                  )
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
}
