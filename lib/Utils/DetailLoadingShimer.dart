import 'package:flutter/material.dart';
import 'package:card_loading/card_loading.dart';

/// Widget for displaying loading shimmer effect for detail screen.
class DetailLoadingShimmer extends StatelessWidget {
  const DetailLoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CardLoading(
          height: height * 0.04,
          width: width * 0.7,
          borderRadius: BorderRadius.circular(25),
        ),
        SizedBox(
          height: height * 0.005,
        ),
        CardLoading(
          height: height * 0.04,
          width: width * 0.4,
          borderRadius: BorderRadius.circular(25),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CardLoading(
          height: height * 0.4,
          width: width * 1,
          borderRadius: BorderRadius.circular(25),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CardLoading(
              height: height * 0.02,
              width: width * 0.15,
              borderRadius: BorderRadius.circular(25),
            ),
            SizedBox(
              width: width * 0.03,
            ),
            CardLoading(
              height: height * 0.02,
              width: width * 0.15,
              borderRadius: BorderRadius.circular(25),
            ),
            Spacer(),
            CardLoading(
              height: height * 0.04,
              width: width * 0.3,
              borderRadius: BorderRadius.circular(25),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.03,
        ),
        CardLoading(
          height: height * 0.04,
          width: width * 0.3,
          borderRadius: BorderRadius.circular(25),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CardLoading(
          height: height * 0.02,
          width: width * 0.6,
          borderRadius: BorderRadius.circular(25),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CardLoading(
          height: height * 0.02,
          width: width * 0.8,
          borderRadius: BorderRadius.circular(25),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        CardLoading(
          height: height * 0.02,
          width: width * 0.4,
          borderRadius: BorderRadius.circular(25),
        ),
      ],
    );
  }
}
