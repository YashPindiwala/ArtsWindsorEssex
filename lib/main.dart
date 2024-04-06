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
import 'package:flutter/services.dart';
import 'package:flutter/src/services/system_chrome.dart';
import 'package:artswindsoressex/Screens/QRCodeScreen.dart';
import 'package:provider/provider.dart';
import 'package:artswindsoressex/ChangeNotifiers/EventProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtHubProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart';
import 'package:artswindsoressex/ChangeNotifiers/NavigationProvider.dart';
import 'package:artswindsoressex/FirebaseSetup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseSetup firebaseSetup = new FirebaseSetup();
  firebaseSetup.initialize();


  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top,SystemUiOverlay.bottom]
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<EventProvider>(create: (context) => EventProvider()),
          ChangeNotifierProvider<ArtHubProvider>(create: (context) => ArtHubProvider()),
          ChangeNotifierProvider<TagProvider>(create: (context) => TagProvider()),
          ChangeNotifierProvider<ArtworkProvider>(create: (context) => ArtworkProvider()),
          ChangeNotifierProvider<NavigationProvider>(create: (context) => NavigationProvider()),
        ],
        child: MyApp(),
      )
  );
}

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
        QrScannerScreen.id: (context) => QrScannerScreen(),
      },
    );
  }
}
