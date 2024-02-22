import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static const id = 'SplashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 50,
            top: 0,
            child: SvgPicture.asset("assets/top_graphic.svg"),
          ),
          Center(
            child: Image.asset('assets/awe_logo.png'),
          ),
          Positioned(
            right: 50,
            bottom: 0,
            child: SvgPicture.asset("assets/bottom_graphic.svg"),
          ),
        ],
      )
    );
  }
}

