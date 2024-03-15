import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    Future.delayed(Duration(milliseconds: 500),() => setState(() {
      position = 0;
      logo = 1.0;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
              left: 50,
              top: position,
              child: SvgPicture.asset("assets/top_graphic.svg"),
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
                  child: Image.asset('assets/awe_logo.png'),
                )
                // Text(change)
              ],
            )
          ),
          AnimatedPositioned(
              right: 50,
              bottom: position,
              child: SvgPicture.asset("assets/bottom_graphic.svg"),
              duration: Duration(milliseconds: 1500)
          ),
        ],
      )
    );
  }
}

