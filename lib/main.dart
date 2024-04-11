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
import 'package:artswindsoressex/ChangeNotifiers/UploadImageProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
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
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
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
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.subscribeToTopic("event");
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_firebaseMessagingBackgroundHandler);

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
          ChangeNotifierProvider<UploadImageProvider>(create: (context) => UploadImageProvider()),
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
