import 'package:artswindsoressex/Screens/AboutApp.dart';
import 'package:artswindsoressex/Screens/CurrentEvents.dart';
import 'package:artswindsoressex/Screens/HomeScreen.dart';
import 'package:artswindsoressex/Screens/UploadSubmitted.dart';
import 'package:flutter/material.dart';
import 'package:artswindsoressex/SplashScreen.dart';
import 'package:artswindsoressex/Screens/forms/UserUploadForm.dart';
import 'package:artswindsoressex/Screens/forms/CommentForm.dart';
import 'package:artswindsoressex/Screens/DetailScreen.dart';
import 'package:artswindsoressex/Screens/CollectionScreen.dart';
import 'package:artswindsoressex/Screens/Navigation.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          useMaterial3: true,
          colorScheme: const ColorScheme.light(
            primary: orangeColor,
          ),
          // scaffoldBackgroundColor: backgroundColor,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: size24, color: textColor),
            headlineMedium: TextStyle(fontSize: size14, color: textColor),
          )
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        UserUploadForm.id: (context) => UserUploadForm(),
        CommentForm.id: (context) => CommentForm(),
        UploadSubmitted.id: (context) => UploadSubmitted(),
        AboutApp.id: (context) => AboutApp(),
        CurrentEvents.id: (context) => CurrentEvents(),
        DetailScreen.id: (context) => DetailScreen(),
        CollectionScreen.id: (context) => CollectionScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        Navigation.id: (context) => Navigation(),
      },
    );
  }
}
