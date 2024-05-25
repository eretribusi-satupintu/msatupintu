import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:satupintu_app/blocs/auth/auth_bloc.dart";
import "package:satupintu_app/blocs/doku_payment/doku_payment_bloc.dart";
import "package:satupintu_app/blocs/rekapitulasi/rekapitulasi_bloc.dart";
import "package:satupintu_app/blocs/tagihan/tagihan_bloc.dart";
import "package:satupintu_app/blocs/tagihan_local/tagihan_local_bloc.dart";
import "package:satupintu_app/blocs/user/user_bloc.dart";
import "package:satupintu_app/services/firebase_notification_services.dart";
import "package:satupintu_app/ui/pages/login_page.dart";
import "package:satupintu_app/ui/pages/main_page.dart";
import "package:satupintu_app/ui/pages/kontrak_list_page.dart";
import "package:satupintu_app/ui/pages/petugas/petugas_qr_code_scanner.dart";
import "package:satupintu_app/ui/pages/petugas/select_wilayah_page.dart";
import "package:satupintu_app/ui/pages/petugas/setoran_list_page.dart";
import "package:satupintu_app/ui/pages/splash_page.dart";
import "package:satupintu_app/ui/pages/timesout_page.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', 'High Importance Notification',
    importance: Importance.high, playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("A bg message just showed up : ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
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
              playSound: true,
              icon: '@drawable/ic_notification',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('test on message open');

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  void showNotification() {
    setState(() {});

    flutterLocalNotificationsPlugin.show(
      0,
      'local notification',
      'This is local notification',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: Importance.high,
          color: Colors.blue,
          playSound: true,
          icon: '@drawable/ic_notification',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()
            ..add(
              AuthGetCurrentUser(),
            ),
        ),
        BlocProvider<DokuPaymentBloc>(
          create: (context) => DokuPaymentBloc(),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc()..add(UserGet()),
        ),
        BlocProvider(create: (context) => TagihanLocalBloc()),
        BlocProvider(create: (context) => TagihanBloc()),
        BlocProvider(create: (context) => RekapitulasiBloc())
        // ..add(TagihanLocalFromServerStore()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/home': (context) => const MainPage(),
          '/login': (context) => const LoginPage(),
          '/subwilayah-select': (context) => const SelectSubWilayahPage(),
          '/petugas-scan-qr-code': (context) => PetugasScanQrCodePage(),
          '/setoran': (context) => const SetoranListPage(),
          '/wajib-retribusi-kontrak': (context) => const KontrakListPage(),
          '/timesout': (context) => const TimesoutPage(),
        },
      ),
    );
  }
}
