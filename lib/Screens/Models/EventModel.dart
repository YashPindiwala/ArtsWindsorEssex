import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:intl/intl.dart';

class EventDetails {
  final String title;
  final String image;
  final String description;
  final String date;
  final String admissionFee;
  final Color cardColor;
  final Color titleColor;
  static int colorIndex = 0;

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
    if(colorIndex >= listOfColors.length)
      colorIndex = 0;

    DateTime date = DateTime.parse(json['event_date']);
    String formattedDate = DateFormat.yMMMMEEEEd().format(date);
    String formattedTime = DateFormat.jm().format(date);

    Color card = listOfColors[colorIndex]["card"]!;
    Color title = listOfColors[colorIndex]["title"]!;

    colorIndex++;
    return EventDetails(
      title: json['title'] ?? '',
      image: json['image_path'] ?? '', // remove the example jpg
      description: json['description'] ?? '',
      date: '$formattedDate at $formattedTime',
      admissionFee: json['admission_fee'].toString() ?? '',
      cardColor: card,
      titleColor: title,
    );
  }

  static List<EventDetails> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => EventDetails.fromJson(json)).toList();
  }
}

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
