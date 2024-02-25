import 'package:flutter/material.dart';
import 'package:artswindsoressex/SplashScreen.dart';
import 'package:artswindsoressex/Screens/forms/UserUploadForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: UserUploadForm.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        UserUploadForm.id: (context) => UserUploadForm()
      },
    );
  }
}
