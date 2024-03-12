import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import '../Screens/Models/EventModel.dart';
import 'package:cached_network_image/cached_network_image.dart';


class ExpandedCardModal extends StatelessWidget {
  final EventDetails selectedEvent;

  const ExpandedCardModal({super.key, required this.selectedEvent});

  @override
  Widget build(BuildContext context) {
    String admissionFeeText = "Admission Fee";
    return Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.8,
          height: MediaQuery
              .of(context)
              .size
              .height * 0.6,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            color: selectedEvent.cardColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: AspectRatio(
                    aspectRatio: 3.3 / 2,
                    child: CachedNetworkImage(
                      imageUrl: selectedEvent.image,
                      fit: BoxFit.fill,
                    )
                  )
              ),
              SizedBox(height: 10,),
              Text(
                selectedEvent.title,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineLarge
                    ?.copyWith(
                    color: selectedEvent.titleColor,
                    fontSize: size18
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text(
                selectedEvent.description,
                textAlign: TextAlign.center,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
              ),
              Spacer(),
              Text(
                selectedEvent.date,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10,),
              Text(
                "${admissionFeeText} - ${selectedEvent.admissionFee}",
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
  }
}
