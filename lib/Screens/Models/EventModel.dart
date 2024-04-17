import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class EventDetails {
  final String title; // The title of the event
  final String image; // The image path of the event
  final String description; // The description of the event
  final String date; // The date and time of the event
  final String admissionFee; // The admission fee for the event
  final Color cardColor; // The color for the event card background
  final Color titleColor; // The color for the event title
  static int colorIndex =
      0; // Static variable to keep track of color index for events

  EventDetails({
    required this.title,
    required this.image,
    required this.description,
    required this.date,
    required this.admissionFee,
    required this.cardColor,
    required this.titleColor,
  });

  factory EventDetails.fromJson(Map<String, dynamic> json) {
    if (colorIndex >=
        listOfColors
            .length) // Reset color index if it exceeds the number of available colors
      colorIndex = 0;

    DateTime date =
        DateTime.parse(json['event_date']); // Parse event date from JSON data
    String formattedDate =
        DateFormat.yMMMMEEEEd().format(date); // Format date as a string
    String formattedTime =
        DateFormat.jm().format(date); // Format time as a string

    Color card =
        listOfColors[colorIndex]["card"]!; // Get card color from list of colors
    Color title = listOfColors[colorIndex]
        ["title"]!; // Get title color from list of colors

    colorIndex++; // Increment color index for the next event

    return EventDetails(
      title: json['title'] ?? '', // Parse event title from JSON data
      image: json['image_path'] ?? '', // Parse event image path from JSON data
      description:
          json['description'] ?? '', // Parse event description from JSON data
      date: '$formattedDate at $formattedTime' ??
          '', // Combine formatted date and time
      admissionFee: json['admission_fee'].toString() ??
          '', // Parse event admission fee from JSON data
      cardColor: card, // Assign card color
      titleColor: title, // Assign title color
    );
  }

  static List<EventDetails> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((json) => EventDetails.fromJson(json))
        .toList(); // Convert JSON list to list of EventDetails objects
  }
}

// Example list of past events
List<EventDetails> pastEvents = [
  EventDetails(
    title: 'St. Clair College Art Exhibition',
    image: 'assets/awe_logo.png',
    description:
        'Join us at St. Clair College South Campus as we showcase our latest artworks.',
    date: 'July 21st from 2 PM - 5 PM',
    admissionFee: '\$10',
    cardColor: pinkColor,
    titleColor: orangeColor,
  ),
  EventDetails(
    title: 'Art Windsor-Essex Color Exhibition',
    image: 'assets/awe_logo.png',
    description:
        'Join us at the Art Windsor-Essex building for our colorful displays. All the current artwork in the show was produced by local artists.',
    date: 'July 21st from 2 PM to 5 PM',
    admissionFee: '\$5',
    cardColor: mintColor,
    titleColor: purpleColor,
  ),
];
