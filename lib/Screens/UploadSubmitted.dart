import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'AboutApp.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/UploadImageProvider.dart';
import 'dart:io';
import 'package:artswindsoressex/constants.dart';

/// Widget for the upload submitted screen.
class UploadSubmitted extends StatefulWidget {
  /// Identifier for the upload submitted screen.
  static const id = "UploadSubmitted";

  const UploadSubmitted({Key? key}) : super(key: key);

  @override
  State<UploadSubmitted> createState() => _UploadSubmittedState();
}

class _UploadSubmittedState extends State<UploadSubmitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AboutApp.id);
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Upload Submitted",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Image.asset("assets/awe_logo.png", width: 100),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "The image you've uploaded will be attached to the image below.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: size14, color: textColor),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        width: 75,
                        height: 75,
                        imageUrl:
                            Provider.of<ArtworkProvider>(context, listen: false)
                                .artwork
                                .image,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Image.asset(
                          "assets/awe_logo.png",
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Thanks for the upload! Check back in a few days to see if your submission has been approved.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: size14, color: textColor),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(Provider.of<UploadImageProvider>(context,
                                  listen: false)
                              .image!
                              .path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    FilledButton(
                      onPressed: () {
                        var artwork =
                            Provider.of<ArtworkProvider>(context, listen: false)
                                .artwork;
                        Provider.of<ArtworkProvider>(context, listen: false)
                            .fetchSingleArtwork(artwork.artwork_id.toString());
                        Navigator.pop(context);
                      },
                      child: const Text("Return"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
