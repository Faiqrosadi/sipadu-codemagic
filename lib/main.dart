// NOT NOTIFICATIONS 
// main.dart
// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/controllers/authentication_controller.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/screens/onboarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  // AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //         channelKey: 'basic_channel',
  //         channelName: 'Notifikasi Sipadu Mobile',
  //         channelDescription:
  //             'Notifikasi untuk menampilkan perubahan jadwal, absensi, dan lainnya')
  //   ],
  //   debug: true,
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // remove debug ribbons

  @override
  Widget build(BuildContext context) {
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     AwesomeNotifications().requestPermissionToSendNotifications();
    //   }
    // });
    return ChangeNotifierProvider(
      create: (context) => AuthenticationController(),
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('id', 'ID'),
        ],
         locale: const Locale('id'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            final authenticationController =
                Provider.of<AuthenticationController>(context);
            return authenticationController.isLoggedIn
                ? const HomeScreen()
                : const OnboardingScreen();
          },
          '/login': (context) => LoginScreen(),
        },
      ),
    );
  }
}
