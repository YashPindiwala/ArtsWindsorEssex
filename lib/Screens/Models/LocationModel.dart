import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constants.dart';

class LocationDetails {
  final String title;
  final String latitude;
  final String longitude;

  LocationDetails({
    required this.title,
    required this.latitude,
    required this.longitude,
  });
}

// // Define the list of locations outside of the LocationDetails class
// List<LocationDetails> locations = [
//   LocationDetails(
//     title: "I Feel Better (than James Brown)",
//     latitude: "42.2468977337425",
//     longitude: "-83.019178100959",
//   ),
//   LocationDetails(
//     title: "Untitled",
//     latitude: "42.246369793486146",
//     longitude: "-83.0183593943187",
//   ),
//   LocationDetails(
//     title: "Paintings With Voices",
//     latitude: "42.24791423797838",
//     longitude: "-83.01899389425428",
//   ),
//   LocationDetails(
//     title: "Summer Cloud",
//     latitude: "42.24721059677366",
//     longitude: "-83.02156191115894",
//   ),
//   LocationDetails(
//     title: "Colors of Fall",
//     latitude: "42.25108402271901",
//     longitude: "-83.01924950110566",
//   ),
//   LocationDetails(
//     title: "Who's There?",
//     latitude: "42.24605250171975",
//     longitude: "-83.01810643822448",
//   ),
//   LocationDetails(
//     title: "Flowers",
//     latitude: "42.24698597666809",
//     longitude: "-83.01668061381424",
//   ),
//   LocationDetails(
//     title: "Maze of Time",
//     latitude: "42.250190728555545",
//     longitude: "-83.02182053242093",
//   ),
//   LocationDetails(
//     title: "The Beginning",
//     latitude: "42.24759816192569",
//     longitude: "-83.02258134793382",
//   ),
//   LocationDetails(
//     title: "Lost In Thought",
//     latitude: "42.24578233080904",
//     longitude: "-83.02048254667761",
//   ),
//   LocationDetails(
//     title: "Pixels",
//     latitude: "42.24721946345446",
//     longitude: "-83.02029890157655",
//   ),
//   LocationDetails(
//     title: "Night Walk",
//     latitude: "42.2528511543059",
//     longitude: "-83.02142700730381",
//   ),
//   LocationDetails(
//     title: "Abstract Development",
//     latitude: "42.24421892636068",
//     longitude: "-83.01502566367499",
//   ),
// ];
