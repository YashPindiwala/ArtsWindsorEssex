import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';

class AboutApp extends StatefulWidget {
  static final id = "AboutApp";

  const AboutApp({super.key});

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: backgroundColor,
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
                      "About This App",
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
                            height: 60,
                          ),
                          const Text(
                            "On this credit screen, we extend our heartfelt gratitude to the talented developers, Chris Green and Yash Pindiwala, whose dedication and expertise brought this app to life."
                            "Their hard work and commitment have made it possible for users to explore and engage with art in innovative ways.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: size14, color: textColor),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "We also express our sincere appreciation to the Zekelman Foundation and St. Clair College for their invaluable support in facilitating the collaboration between their students and Art Windsor-Essex to create this app."
                            "Their efforts in connecting developers with our organization and fostering a collaborative environment have been instrumental in bringing this project to fruition."
                            "Together, we have worked in unison to enrich the cultural landscape of our community, allowing art to transcend boundaries and inspire creativity.",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: size14, color: textColor),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              const Spacer(),
                              OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: orangeColor)),
                                  child: const Text("Visit AWE")),
                              const Spacer(),
                              FilledButton(
                                  onPressed: () {},
                                  child: const Text("Visit SCC")),
                              const Spacer(),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
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
