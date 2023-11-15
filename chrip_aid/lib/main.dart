import 'package:chrip_aid/auth/provider/authority_provider.dart';
import 'package:chrip_aid/common/firebase/fcm.dart';
import 'package:chrip_aid/common/go_router/go_router.dart';
import 'package:chrip_aid/common/google_map/google_map.dart';
import 'package:chrip_aid/common/utils/aws_utils.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await initFCM();
  await initGoogleMap();
  await initAuthority();
  initAWS();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key}) {
    FirebaseMessaging.onMessage.listen(listenFCM);
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
