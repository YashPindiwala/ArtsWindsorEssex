import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:artswindsoressex/Screens/Navigation.dart';
import 'package:artswindsoressex/ChangeNotifiers/EventProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtHubProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:provider/provider.dart';



class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  double position = -320;
  double logo = 0.0;
  String change = "Change happens here.";

  void initState() {
    super.initState();
    Provider.of<ArtworkProvider>(context, listen: false).fetchArtwork();
    Provider.of<EventProvider>(context, listen: false).fetchCurrEvents();
    Provider.of<EventProvider>(context, listen: false).fetchPastEvents();
    Provider.of<ArtHubProvider>(context, listen: false).fetchArtHub();
    Provider.of<TagProvider>(context, listen: false).fetchTags();
    Future.delayed(Duration(milliseconds: 2500),() => Navigator.popAndPushNamed(context, Navigation.id));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    Future.delayed(Duration(milliseconds: 500),() => setState(() {
      position = screenSize.height * 0.00;
      logo = 1.0;
    }));
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              left: screenSize.width * 0.1,
              top: position,
              child: SvgPicture.asset("assets/top_graphic.svg", height: screenSize.height * 0.4,),
              duration: Duration(milliseconds: 1500)
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedOpacity(
                  duration: Duration(milliseconds: 1500),
                  opacity: logo,
                  child: Image.asset('assets/awe_logo.png', height: screenSize.height * 0.25),
                )
                // Text(change)
              ],
            )
          ),
          AnimatedPositioned(
              right: screenSize.width * 0.1,
              bottom: position,
              child: SvgPicture.asset("assets/bottom_graphic.svg", height: screenSize.height * 0.4),
              duration: Duration(milliseconds: 1500)
          ),
        ],
      )
    );
  }
}