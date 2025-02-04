import 'package:artswindsoressex/constants.dart';
import 'package:flutter/material.dart';

class ArtworkScanned {
   int? id; // Making id optional
   int artworkId;
   String title;
   String description;
   String location;
   String imageUrl;
   bool unlocked;
  Color cardColor = orangeColor;
  Color titleColor = orangeColor;
  static int colorIndex = 0;

   ArtworkScanned.empty()
       : id = null,
         artworkId = 0,
         title = 'Unknown',
         description = '',
         location = '',
         imageUrl = '',
         unlocked = false {
     if (colorIndex >= listOfColors.length) colorIndex = 0;
     cardColor = listOfColors[colorIndex]['card']!;
     titleColor = listOfColors[colorIndex]['title']!;
     colorIndex++;
   }

  ArtworkScanned.db({
    this.id, // Making id optional
    required this.artworkId,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.unlocked,
  });

  ArtworkScanned({
    this.id, // Making id optional
    required this.artworkId,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
    required this.unlocked,
    required this.cardColor,
    required this.titleColor,
  });

  factory ArtworkScanned.fromMap(Map<String, dynamic> map) {
    if(colorIndex >= listOfColors.length)
        colorIndex = 0;

      Color card = listOfColors[colorIndex]["card"]!;
      Color title = listOfColors[colorIndex]["title"]!;
      colorIndex++;
    return ArtworkScanned(
      id: map['id'],
      artworkId: map['artwork_id'],
      title: map['title'],
      description: map['description'],
      location: map['location'],
      imageUrl: map['image_url'],
      unlocked: map['unlocked'] == 1,
      cardColor: card,
      titleColor: title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Include id in the map only if it's not null
      'artwork_id': artworkId,
      'title': title,
      'description': description,
      'location': location,
      'image_url': imageUrl,
      'unlocked': unlocked ? 1 : 0,
    };
  }
}
