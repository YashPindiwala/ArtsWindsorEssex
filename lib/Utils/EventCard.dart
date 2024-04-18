import 'package:flutter/material.dart'; // Importing material package
import 'dart:ui'; // Importing dart:ui package for ImageFilter
import 'package:cached_network_image/cached_network_image.dart'; // Importing cached_network_image package
import '../constants.dart'; // Importing custom constants
import '../Screens/Models/EventModel.dart'; // Importing EventModel
import 'ExpandedCardModal.dart'; // Importing ExpandedCardModal widget

class EventCard extends StatelessWidget {
  final EventDetails eventDetails;

  const EventCard({
    required this.eventDetails,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) =>
              _cardDialog(context), // Calling the _cardDialog method
        );
      },
      child: Card(
        color: eventDetails.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                eventDetails.title,
                style: TextStyle(
                  fontSize: size18,
                  fontWeight: FontWeight.bold,
                  color: eventDetails.titleColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: eventDetails.image,
                        fit: BoxFit.fill,
                        errorWidget: (context, url, error) => Image.asset(
                            "assets/awe_logo.png"), // Placeholder image in case of error
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      eventDetails.description,
                      style: const TextStyle(
                          fontSize: size13,
                          color:
                              textColor), // Customizing text style based on constants
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      eventDetails.date,
                      style: const TextStyle(
                        fontSize: size12,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                  Text(
                    'Admission: ${eventDetails.admissionFee}',
                    style: const TextStyle(
                      fontSize: size12,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cardDialog(BuildContext context) {
    return BackdropFilter(
      filter:
          ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Applying blur effect
      child: Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ExpandedCardModal(
                selectedEvent:
                    eventDetails), // Showing ExpandedCardModal with selected event details
            SizedBox(height: 10),
            FilledButton(
              onPressed: () {}, // Placeholder onPressed function
              child: Text(
                "Visit Our Site",
                style: TextStyle(color: eventDetails.titleColor),
              ),
              style: FilledButton.styleFrom(
                backgroundColor: eventDetails
                    .cardColor, // Customizing button background color based on event details
              ),
            )
          ],
        ),
      ),
    );
  }
}
