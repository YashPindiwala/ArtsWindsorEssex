import 'package:flutter/material.dart';
import '../Screens/Models/EventModel.dart';
import '../constants.dart';

class EventCard extends StatelessWidget {
  final EventDetails eventDetails;
  final Function() onPressed;

  const EventCard({
    required this.eventDetails,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        color: eventDetails.cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 10),
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
                      child: Image.network(
                        eventDetails.image,
                        fit: BoxFit.cover,
                      ),
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
}
