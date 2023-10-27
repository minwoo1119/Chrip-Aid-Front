import 'package:chrip_aid/common/go_router/go_router.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:chrip_aid/firebase_options.dart';
import 'package:chrip_aid/orphanage/view/orphanage_basket_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_donate_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_post_screen.dart';
import 'package:chrip_aid/orphanage/view/orphanage_reservation_screen.dart';
import 'package:chrip_aid/orphanage/view/reservation_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

AndroidMapRenderer mapRenderer = AndroidMapRenderer.platformDefault;

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  var initializationSettingsIOS = const DarwinInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    mapRenderer = await mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.platformDefault);
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      var androidNotifyDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
      );
      var iOSNotifyDetails = const DarwinNotificationDetails();
      var details = NotificationDetails(
          android: androidNotifyDetails, iOS: iOSNotifyDetails);
      if (notification != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          details,
        );

        message.data["title"] = notification.title;
        message.data["body"] = notification.body;
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(routerProvider);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // 디버그 표시 지우기
      scaffoldMessengerKey: SnackBarUtil.key,
      title: 'Kumoh42 Futsal Reservation System',
      routerConfig: route,
    );
  }
}
