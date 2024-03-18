import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_app/screens/onboarding_screen.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    print(message.notification!.title.toString());
  }
  if (kDebugMode) {
    print(message.notification!.body.toString());
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isDarkMode = brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
      ),
      child: MaterialApp(
        // theme: isDarkMode ? ThemeData.dark(useMaterial3: true, ) : ThemeData.light(useMaterial3: true),
        theme: isDarkMode
            ? ThemeData.dark().copyWith(
          textTheme: GoogleFonts.nunitoSansTextTheme().apply(bodyColor: Colors.white
          ),
        ) : ThemeData.light().copyWith(
          textTheme: GoogleFonts.nunitoSansTextTheme().apply(
          ),
        ),
        debugShowCheckedModeBanner: false,
        title: 'AMart',
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data != null) {
              return const BottomNavBar();
            } else {
              return const OnboardingScreen();
            }
          },
        ),
      ),
    );
  }
}
