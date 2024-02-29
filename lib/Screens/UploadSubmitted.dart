import 'package:artswindsoressex/constants.dart';
import 'package:flutter/material.dart';

import 'AboutApp.dart';

class UploadSubmitted extends StatefulWidget {
  static const id = "UploadSubmitted";

  const UploadSubmitted({super.key});

  @override
  State<UploadSubmitted> createState() => _UploadSubmittedState();
}

class _UploadSubmittedState extends State<UploadSubmitted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: backgroundColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AboutApp()),
              );
            },
            icon: const Icon(Icons.info_outline_rounded),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    const Text(
                      "Upload Submitted",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: size24,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    Image.asset("assets/awe_logo.png", width: 60)
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "The image you've uploaded will be attached to the image below.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: size14, color: textColor),
                          ),
                          Image.asset("assets/awe_logo.png", width: 100),
                          const SizedBox(height: 40),
                          const Text(
                            "Thanks for the upload! Check back in a few days to see if your submission has been approved.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: size14, color: textColor),
                          ),
                          Image.asset("assets/awe_logo.png", width: 250),
                          Row(
                            children: [
                              const Spacer(),
                              const Spacer(),
                              OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: orangeColor)),
                                  child: const Text("Upload Image")),
                              const Spacer(),
                              FilledButton(
                                  onPressed: () {},
                                  child: const Text("Return")),
                              const Spacer(),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
