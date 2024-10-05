import 'package:chrip_aid/common/firebase/fcm.dart';
import 'package:chrip_aid/common/google_map/google_map.dart';
import 'package:chrip_aid/common/utils/aws_utils.dart';
import 'package:chrip_aid/common/utils/snack_bar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'notice/view/notice_popup.dart'; // NoticePopup 임포트

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await initGoogleMap();
  initAWS();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: SnackBarUtil.key,
      title: 'Chirp Aid',
      home: NoticePopupTestScreen(),  // 테스트용으로 NoticePopup을 메인으로 설정
    );
  }
}

class NoticePopupTestScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NoticePopup(); // NoticePopup을 표시
        },
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notice Test'),
      ),
      body: const Center(
        child: Text('Testing Notice Popup'),
      ),
    );
  }
}


/*
import 'package:chrip_aid/auth/model/state/authority_state.dart';
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
*/