// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
// import 'package:shopping_app/home/home_screen.dart';
// import 'package:shopping_app/screens/forgot_password.dart';
// import 'package:shopping_app/screens/signup_screen.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:twitter_login/twitter_login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class SignInScreen extends StatefulWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SignInScreen> createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//
//   bool _obscureText = true;
//   bool _rememberMe = false;
//
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final FacebookAuth _facebookAuth = FacebookAuth.instance;
//   final TwitterLogin _twitterLogin = TwitterLogin(
//     apiKey: 'YOUR_TWITTER_API_KEY',
//     apiSecretKey: 'YOUR_TWITTER_API_SECRET_KEY',
//     redirectURI: 'YOUR_TWITTER_REDIRECT_URI',
//   );
//
//   Future<void> _signInWithEmailAndPassword() async {
//     try {
//       UserCredential userCredential =
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       debugPrint('User signed in: ${userCredential.user!.uid}');
//       _rememberUser();
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const BottomNavBar()),
//       );
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         debugPrint('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         debugPrint('Wrong password provided.');
//       }
//     }
//   }
//
//   Future<void> _signInWithGoogle() async {
//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser != null) {
//         final googleAuth = await googleUser.authentication;
//         final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken,
//           idToken: googleAuth.idToken,
//         );
//         final userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         debugPrint('User signed in: ${userCredential.user!.uid}');
//         _rememberUser();
//         _saveUserToFirestore(userCredential.user!);
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error signing in with Google: $e');
//     }
//   }
//
//   Future<void> _signInWithFacebook() async {
//     try {
//       final result = await _facebookAuth.login();
//       if (result.status == LoginStatus.success) {
//         final accessToken = result.accessToken!.token;
//         final credential = FacebookAuthProvider.credential(accessToken);
//         final userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         debugPrint('User signed in: ${userCredential.user!.uid}');
//         _rememberUser();
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error signing in with Facebook: $e');
//     }
//   }
//
//   Future<void> _signInWithTwitter() async {
//     try {
//       final twitterLogin = await _twitterLogin.loginV2();
//       if (twitterLogin.status == TwitterLoginStatus.loggedIn) {
//         final credential = TwitterAuthProvider.credential(
//           accessToken: twitterLogin.authToken!,
//           secret: twitterLogin.authTokenSecret!,
//         );
//         final userCredential =
//         await FirebaseAuth.instance.signInWithCredential(credential);
//         debugPrint('User signed in: ${userCredential.user!.uid}');
//         _rememberUser(); // Call the _rememberUser function
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const HomeScreen()),
//         );
//       }
//     } catch (e) {
//       debugPrint('Error signing in with Twitter: $e');
//     }
//   }
//
//   Future<void> _rememberUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     if (_rememberMe) {
//       // Save user credentials
//       prefs.setBool('rememberMe', true);
//       prefs.setString('email', _emailController.text);
//       prefs.setString('password', _passwordController.text);
//     } else {
//       // Clear user credentials
//       prefs.setBool('rememberMe', false);
//       prefs.remove('email');
//       prefs.remove('password');
//     }
//   }
//
//   Future<void> _loadUserCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     _rememberMe = prefs.getBool('rememberMe') ?? false;
//     if (_rememberMe) {
//       _emailController.text = prefs.getString('email') ?? '';
//       _passwordController.text = prefs.getString('password') ?? '';
//     }
//   }
//
//   Future<void> _saveUserToFirestore(User user) async {
//     final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
//
//     final userData = {
//       'uid': user.uid,
//       'email': user.email,
//       'firstName': user.displayName?.split(' ')[0],
//       'lastName': user.displayName?.split(' ')[1],
//       'username' : user.displayName?.split(' ')[2],
//       'photoURL': user.photoURL,
//     };
//
//     await userRef.set(userData, SetOptions(merge: true));
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserCredentials();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       // appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 30),
//             Text(
//               "Welcome Back",
//               style: GoogleFonts.nunitoSans(
//                   textStyle: const TextStyle(
//                       fontWeight: FontWeight.bold, fontSize: 30)),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Sign in with your email and password \n continue with social media",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.nunitoSans(
//                   textStyle: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 15,
//                       color: Colors.grey)),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: 'E-mail',
//                       labelStyle:
//                       GoogleFonts.nunitoSans(textStyle: const TextStyle()),
//                       hintText: 'Enter your email',
//                       hintStyle:
//                       GoogleFonts.nunitoSans(textStyle: const TextStyle()),
//                       suffixIcon: const Icon(Iconsax.sms),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Enter your email';
//                       }
//                       // You can add more email validation here
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       labelStyle:
//                       GoogleFonts.nunitoSans(textStyle: const TextStyle()),
//                       hintText: 'Enter your password',
//                       hintStyle:
//                       GoogleFonts.nunitoSans(textStyle: const TextStyle()),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           color: Colors.grey,
//                           _obscureText ? Iconsax.eye_slash : Iconsax.eye,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureText = !_obscureText;
//                           });
//                         },
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter your password';
//                       }
//                       // You can add more password validation here
//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _rememberMe,
//                             onChanged: (value) {
//                               setState(() {
//                                 _rememberMe = value!;
//                               });
//                             },
//                           ),
//                           Text(
//                             'Remember me',
//                             style: GoogleFonts.nunitoSans(
//                                 textStyle: const TextStyle(fontSize: 15)),
//                           ),
//                         ],
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const ForgotPassword(),
//                             ),
//                           );
//                         },
//                         child: Text(
//                           'Forgot Password?',
//                           style: GoogleFonts.nunitoSans(
//                               textStyle: const TextStyle(fontSize: 15)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                   MaterialStateProperty.all<Color>(Colors.deepOrange),
//                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _signInWithEmailAndPassword();
//                   }
//                 },
//                 child: Text(
//                   'SIGN IN',
//                   style: GoogleFonts.nunitoSans(
//                       textStyle: const TextStyle(
//                           fontSize: 15,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 50),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: _signInWithGoogle,
//                       icon: SvgPicture.asset(
//                         "assets/icons/google-icon.svg",
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: _signInWithFacebook,
//                       icon: SvgPicture.asset(
//                         "assets/icons/facebook-2.svg",
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       shape: BoxShape.circle,
//                     ),
//                     child: IconButton(
//                       onPressed: _signInWithTwitter,
//                       icon: SvgPicture.asset(
//                         "assets/icons/twitter.svg",
//                         height: 25,
//                         width: 25,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Don't have an account?",
//                   style: GoogleFonts.nunitoSans(
//                       textStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const SignupScreen(),
//                       ),
//                     );
//                   },
//                   child: Text(
//                     'Sign Up',
//                     style: GoogleFonts.nunitoSans(
//                         textStyle: const TextStyle(
//                             fontSize: 15, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_app/home/home_screen.dart';
import 'package:shopping_app/screens/forgot_password.dart';
import 'package:shopping_app/screens/signup_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureText = true;
  bool _rememberMe = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final TwitterLogin _twitterLogin = TwitterLogin(
    apiKey: 'YOUR_TWITTER_API_KEY',
    apiSecretKey: 'YOUR_TWITTER_API_SECRET_KEY',
    redirectURI: 'YOUR_TWITTER_REDIRECT_URI',
  );

  Future<void> _saveUserToFirestore(User user) async {
    final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final userData = {
      'uid': user.uid,
      'email': user.email,
      'firstName': user.displayName?.split(' ')[0],
      'lastName': user.displayName?.split(' ')[1],
      'username' : user.displayName?.split(' ')[2],
      'photoURL': user.photoURL,
    };

    await userRef.set(userData, SetOptions(merge: true));
  }


  Future<void> _signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint('User signed in: ${userCredential.user!.uid}');
        _rememberUser();
        _saveUserToFirestore(userCredential.user!);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error signing in with Google: $e');
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      final result = await _facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final accessToken = result.accessToken!.token;
        final credential = FacebookAuthProvider.credential(accessToken);
        final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint('User signed in: ${userCredential.user!.uid}');
        _rememberUser();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error signing in with Facebook: $e');
    }
  }

  Future<void> _signInWithTwitter() async {
    try {
      final twitterLogin = await _twitterLogin.loginV2();
      if (twitterLogin.status == TwitterLoginStatus.loggedIn) {
        final credential = TwitterAuthProvider.credential(
          accessToken: twitterLogin.authToken!,
          secret: twitterLogin.authTokenSecret!,
        );
        final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
        debugPrint('User signed in: ${userCredential.user!.uid}');
        _rememberUser(); // Call the _rememberUser function
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error signing in with Twitter: $e');
    }
  }

  // Future<void> _signInWithEmailAndPassword() async {
  //   try {
  //     if (_formKey.currentState!.validate()) {
  //       UserCredential userCredential =
  //       await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text,
  //         password: _passwordController.text,
  //       );
  //       debugPrint('User signed in: ${userCredential.user!.uid}');
  //       _rememberUser();
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const BottomNavBar()),
  //       );
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       _showSnackbar('No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       _showSnackbar('Wrong password provided.');
  //     } else {
  //       _showSnackbar('Error signing in: ${e.message}');
  //     }
  //   } catch (e) {
  //     _showSnackbar('Error signing in: $e');
  //   }
  // }


  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        debugPrint('User signed in: ${userCredential.user!.uid}');
        _rememberUser();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavBar()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showSnackbar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        _showSnackbar(context, 'Wrong password provided.');
      } else {
        _showSnackbar(context, 'Error signing in: ${e.message}');
      }
    } catch (e) {
      _showSnackbar(context, 'Error signing in: $e');
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _rememberUser() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      // Save user credentials
      prefs.setBool('rememberMe', true);
      prefs.setString('email', _emailController.text);
      prefs.setString('password', _passwordController.text);
    } else {
      // Clear user credentials
      prefs.setBool('rememberMe', false);
      prefs.remove('email');
      prefs.remove('password');
    }
  }

  Future<void> _loadUserCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    _rememberMe = prefs.getBool('rememberMe') ?? false;
    if (_rememberMe) {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Welcome Back",
              style: (
                  TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            const SizedBox(height: 10),
            const Text(
              "Sign in with your email and password \n continue with social media",
              textAlign: TextAlign.center,
              style:TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.grey),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      // labelStyle: GoogleFonts.nunitoSans(textStyle: const TextStyle()),
                      hintText: 'Enter your email',
                      // hintStyle: GoogleFonts.nunitoSans(textStyle: const TextStyle()),
                      suffixIcon: const Icon(Iconsax.sms),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      // You can add more email validation here
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      // labelStyle: GoogleFonts.nunitoSans(textStyle: const TextStyle()),
                      hintText: 'Enter your password',
                      // hintStyle: GoogleFonts.nunitoSans(textStyle: const TextStyle()),
                      suffixIcon: IconButton(
                        icon: Icon(
                          color: Colors.grey,
                          _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // You can add more password validation here
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value!;
                              });
                            },
                          ),
                          const Text(
                            'Remember me',
                            style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: const Text(
                          'Forgot Password?',
                          style:TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.deepOrange),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                onPressed: (){
                  _signInWithEmailAndPassword(context);
                },
                child: const Text(
                  'SIGN IN',
                  style:TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _signInWithGoogle,
                      icon: SvgPicture.asset(
                        "assets/icons/google-icon.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _signInWithFacebook,
                      icon: SvgPicture.asset(
                        "assets/icons/facebook-2.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: _signInWithTwitter,
                      icon: SvgPicture.asset(
                        "assets/icons/twitter.svg",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
