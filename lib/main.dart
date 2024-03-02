import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_app/screens/onboarding_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AMart',
      theme: ThemeData(
        // Define your app's theme here if needed
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Return a loading indicator if the authentication state is loading
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data != null) {
            // If the user is authenticated, show the bottom navigation bar
            return const MyBottomNavBar();
          } else {
            // If the user is not authenticated, show the onboarding screen
            return const OnboardingScreen();
          }
        },
      ),
    );
  }
}
