import 'package:flutter/material.dart';
import 'package:artswindsoressex/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutApp extends StatefulWidget {
  static const id = "AboutApp";

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
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
      ),
      body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("About This App",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
            Image.asset("assets/awe_logo.png", width: 60),
            Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 25,left: 25,right: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "On this credit screen, we extend our heartfelt gratitude to the talented developers, Chris Green and Yash Pindiwala, whose dedication and expertise brought this app to life."
                              "Their hard work and commitment have made it possible for users to explore and engage with art in innovative ways.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "We also express our sincere appreciation to the Zekelman Foundation and St. Clair College for their invaluable support in facilitating the collaboration between their students and Art Windsor-Essex to create this app."
                              "Their efforts in connecting developers with our organization and fostering a collaborative environment have been instrumental in bringing this project to fruition."
                              "Together, we have worked in unison to enrich the cultural landscape of our community, allowing art to transcend boundaries and inspire creativity.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            const Spacer(),
                            OutlinedButton(
                                onPressed: () async {
                                  if (await canLaunchUrl(Uri.parse(siteHomeUrl))) {
                                  await launchUrl(Uri.parse(siteHomeUrl), mode: LaunchMode.externalApplication, );
                                  } else {
                                  throw 'Could not launch $siteHomeUrl';
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: orangeColor)),
                                child: const Text("Visit AWE")),
                            const Spacer(),
                            FilledButton(
                                onPressed: () async {
                                  if (await canLaunchUrl(Uri.parse(siteScWebStClair))) {
                                  await launchUrl(Uri.parse(siteScWebStClair), mode: LaunchMode.externalApplication, );
                                  } else {
                                  throw 'Could not launch $siteScWebStClair';
                                  }
                                }, child: const Text("Visit SCC")),
                            const Spacer(),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  )
                ),
            ),
          ],
        ),
    );
  }
}
