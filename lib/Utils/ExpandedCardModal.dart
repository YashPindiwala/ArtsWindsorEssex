import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import '../Screens/Models/EventModel.dart';

class ExpandedCardModal extends StatelessWidget {
  final EventDetails selectedEvent;

  const ExpandedCardModal({super.key, required this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.6,
      color: selectedEvent.cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              selectedEvent.title,
              style: const TextStyle(
                fontSize: size18,
                fontWeight: FontWeight.bold,
                color: purpleColor,
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
                    child: Image.asset(
                      selectedEvent.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    selectedEvent.description,
                    style: const TextStyle(fontSize: size13, color: textColor),
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
                        selectedEvent.date,
                        style: const TextStyle(
                          fontSize: size12,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ),
                    Text(
                      'Admission: ${selectedEvent.admissionFee}',
                      style: const TextStyle(
                        fontSize: size12,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement your action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedEvent.cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Visit Our Site',
                    style: TextStyle(
                      color: selectedEvent.titleColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
