import 'package:flutter/material.dart';
import '../Screens/Models/EventModel.dart';
import '../constants.dart';
import 'ExpandedCardModal.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';


class EventCard extends StatelessWidget {
  final EventDetails eventDetails;
  // final Function() onPressed;

  const EventCard({
    required this.eventDetails,
    // required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (context) => _cardDialog(),
        );
      },
      child: Card(
        color: eventDetails.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        // margin: const EdgeInsets.symmetric(vertical: 0),
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
                        errorWidget: (context, url, error) => Image.asset("assets/awe_logo.png",)
                      )
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      eventDetails.description,
                      style:
                          const TextStyle(fontSize: size13, color: textColor),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _cardDialog(){
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0,sigmaY: 5.0),
        child: Dialog(
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ExpandedCardModal(selectedEvent: eventDetails),
                SizedBox(height: 10,),
                FilledButton(
                  onPressed: () async {
                    if (await canLaunchUrl(Uri.parse(siteEventUrl))) {
                      await launchUrl(Uri.parse(siteEventUrl), mode: LaunchMode.externalApplication, );
                    } else {
                      throw 'Could not launch $siteEventUrl';
                    }
                  },
                  child: Text("Visit Our Site", style: TextStyle(color: eventDetails.titleColor),),
                  style: FilledButton.styleFrom(
                    backgroundColor: eventDetails.cardColor, // Background color
                  ),
                )
              ],
            )
        ),
    );
  }

}
