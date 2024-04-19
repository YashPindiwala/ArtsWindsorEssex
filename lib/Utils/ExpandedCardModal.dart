import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import '../Screens/Models/EventModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExpandedCardModal extends StatelessWidget {
  final EventDetails selectedEvent;

  const ExpandedCardModal({Key? key, required this.selectedEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String admissionFeeText = "Admission Fee";
    return SingleChildScrollView(
      // physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: selectedEvent.cardColor,
          borderRadius: BorderRadius.circular(25),
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
                  errorWidget: (context, url, error) => Image.asset("assets/awe_logo.png"),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              selectedEvent.title,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: selectedEvent.titleColor, fontSize: size18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              selectedEvent.description,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            Text(
              selectedEvent.date,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "${admissionFeeText} - ${selectedEvent.admissionFee}",
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
