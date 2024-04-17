import 'dart:ui'; // Importing dart:ui package for ImageFilter
import 'package:flutter/material.dart'; // Importing material package
import 'package:artswindsoressex/constants.dart'; // Importing custom constants
import '../Screens/Models/EventModel.dart'; // Importing EventModel
import 'package:cached_network_image/cached_network_image.dart'; // Importing cached_network_image package

class ExpandedCardModal extends StatelessWidget {
  final EventDetails selectedEvent;

  const ExpandedCardModal({Key? key, required this.selectedEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String admissionFeeText = "Admission Fee"; // Text for admission fee

    return SingleChildScrollView(
      // Making the content scrollable
      child: Container(
        width: MediaQuery.of(context).size.width *
            0.8, // Setting width to 80% of screen width
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 15), // Setting padding
        decoration: BoxDecoration(
          color: selectedEvent
              .cardColor, // Setting background color from selectedEvent
          borderRadius: BorderRadius.circular(25), // Setting border radius
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: AspectRatio(
                aspectRatio: 3.3 / 2,
                child: CachedNetworkImage(
                  imageUrl: selectedEvent.image,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => Image.asset(
                      "assets/awe_logo.png"), // Placeholder image in case of error
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedEvent.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: selectedEvent.titleColor,
                  fontSize:
                      size18), // Customizing text style based on theme and selectedEvent
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              selectedEvent.description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium, // Customizing text style based on theme
            ),
            SizedBox(height: 10),
            Text(
              selectedEvent.date,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium, // Customizing text style based on theme
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "$admissionFeeText - ${selectedEvent.admissionFee}",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium, // Customizing text style based on theme
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
