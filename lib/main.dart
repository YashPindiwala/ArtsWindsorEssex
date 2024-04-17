import 'package:flutter/material.dart'; // Importing material package
import 'package:flutter/services.dart'; // Importing services package for SystemChrome
import 'package:flutter/src/services/system_chrome.dart'; // Importing SystemChrome from services package
import 'package:firebase_core/firebase_core.dart'; // Importing Firebase Core package
import 'firebase_options.dart'; // Importing Firebase options file
import 'package:firebase_messaging/firebase_messaging.dart'; // Importing Firebase Messaging package
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Importing Flutter Local Notifications package
import 'package:provider/provider.dart'; // Importing provider package
import 'package:artswindsoressex/ChangeNotifiers/EventProvider.dart'; // Importing EventProvider
import 'package:artswindsoressex/ChangeNotifiers/ArtHubProvider.dart'; // Importing ArtHubProvider
import 'package:artswindsoressex/ChangeNotifiers/TagProvider.dart'; // Importing TagProvider
import 'package:artswindsoressex/ChangeNotifiers/ArtworkProvider.dart'; // Importing ArtworkProvider
import 'package:artswindsoressex/ChangeNotifiers/NavigationProvider.dart'; // Importing NavigationProvider
import 'package:artswindsoressex/ChangeNotifiers/UploadImageProvider.dart'; // Importing UploadImageProvider
import 'package:artswindsoressex/ChangeNotifiers/ArtworkDB.dart'; // Importing ArtworkDB
import 'constants.dart'; // Importing custom constants
import 'package:artswindsoressex/SplashScreen.dart'; // Importing SplashScreen
import 'package:artswindsoressex/Screens/forms/UserUploadForm.dart'; // Importing UserUploadForm
import 'package:artswindsoressex/Screens/forms/CommentForm.dart'; // Importing CommentForm
import 'package:artswindsoressex/Screens/UploadSubmitted.dart'; // Importing UploadSubmitted
import 'package:artswindsoressex/Screens/AboutApp.dart'; // Importing AboutApp
import 'package:artswindsoressex/Screens/CurrentEvents.dart'; // Importing CurrentEvents
import 'package:artswindsoressex/Screens/DetailScreen.dart'; // Importing DetailScreen
import 'package:artswindsoressex/Screens/CollectionScreen.dart'; // Importing CollectionScreen
import 'package:artswindsoressex/Screens/HomeScreen.dart'; // Importing HomeScreen
import 'package:artswindsoressex/Screens/Navigation.dart'; // Importing Navigation
import 'package:artswindsoressex/Screens/QRCodeScreen.dart'; // Importing QRCodeScreen

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.currentPlatform); // Initializing Firebase app
  await setupFlutterNotifications(); // Setting up Flutter notifications
  showFlutterNotification(message); // Showing Flutter notification
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/launcher_icon',
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.currentPlatform); // Initializing Firebase app
  await FirebaseMessaging.instance
      .requestPermission(); // Requesting permission for Firebase messaging
  await FirebaseMessaging.instance
      .subscribeToTopic("event"); // Subscribing to "event" topic
  FirebaseMessaging.onBackgroundMessage(
      _firebaseMessagingBackgroundHandler); // Handling background message

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<EventProvider>(
          create: (context) => EventProvider()), // Providing EventProvider
      ChangeNotifierProvider<ArtHubProvider>(
          create: (context) => ArtHubProvider()), // Providing ArtHubProvider
      ChangeNotifierProvider<TagProvider>(
          create: (context) => TagProvider()), // Providing TagProvider
      ChangeNotifierProvider<ArtworkProvider>(
          create: (context) => ArtworkProvider()), // Providing ArtworkProvider
      ChangeNotifierProvider<NavigationProvider>(
          create: (context) =>
              NavigationProvider()), // Providing NavigationProvider
      ChangeNotifierProvider<UploadImageProvider>(
          create: (context) =>
              UploadImageProvider()), // Providing UploadImageProvider
      ChangeNotifierProvider<ArtworkDB>(
          create: (context) => ArtworkDB()), // Providing ArtworkDB
    ],
    child: MyApp(), // Running the MyApp widget under the provider
  ));
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
            headlineLarge: TextStyle(
                fontSize: size24, color: textColor, fontFamily: "Epilogue"),
            headlineMedium: TextStyle(
                fontSize: size14, color: textColor, fontFamily: "Epilogue"),
          )),
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
