
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_app/screens/signin_screen.dart';
import 'package:twitter_login/twitter_login.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),), centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Register Account",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.grey)),
              SignupForm(auth: _auth, firestore: _firestore),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const SignupForm({super.key, required this.auth, required this.firestore});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _usernameController = TextEditingController();
  final _genderController = TextEditingController();
  final _dobController = TextEditingController();
  bool _obscureText = true;
  bool _obscureText1 = true;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final TwitterLogin _twitterLogin = TwitterLogin(
    apiKey: 'YOUR_TWITTER_API_KEY',
    apiSecretKey: 'YOUR_TWITTER_API_SECRET_KEY',
    redirectURI: 'YOUR_TWITTER_REDIRECT_URI',
  );



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
        // _rememberUser();
        // _saveUserToFirestore(userCredential.user!);
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
        // _rememberUser();
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
        // _rememberUser();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    } catch (e) {
      debugPrint('Error signing in with Twitter: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: const TextStyle(fontSize: 15),
                      hintStyle: const TextStyle(fontSize: 15),
                      hintText: 'Enter your first name',
                      suffixIcon: const Icon(Iconsax.user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 15),
                      hintStyle: const TextStyle(fontSize: 15),
                      labelText: 'Last Name',
                      hintText: 'Enter your last name',
                      suffixIcon: const Icon(Iconsax.user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 15),
                      hintStyle: const TextStyle(fontSize: 15),
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      suffixIcon: const Icon(Iconsax.user),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Enter your username';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 15),
                      hintStyle: const TextStyle(fontSize: 15),
                      labelText: 'Phone Number',
                      hintText: 'Enter your phone number',
                      suffixIcon: const Icon(Iconsax.call),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Enter your phone number';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _genderController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 15),
                      hintStyle: const TextStyle(fontSize: 15),
                      labelText: 'Gender',
                      hintText: 'Enter your gender',
                      suffixIcon: const Icon(Iconsax.man),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Enter your gender';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: TextFormField(
                    controller: _dobController,
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 15),
                      hintStyle: const TextStyle(fontSize: 15),
                      labelText: 'Date of Birth',
                      hintText: 'Enter your date of birth',
                      suffixIcon: const Icon(Iconsax.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return 'Enter your date of birth';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelStyle: const TextStyle(fontSize: 15),
                hintStyle: const TextStyle(fontSize: 15),
                labelText: 'E-mail',
                hintText: 'Enter your email',
                suffixIcon: const Icon(Iconsax.sms),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your email';
                }
                return null;
              },
            ),

            const SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                labelStyle: const TextStyle(fontSize: 15),
                hintStyle: const TextStyle(fontSize: 15),
                labelText: 'Password',
                hintText: 'Enter your password',
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
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _confirmPasswordController,
              obscureText: _obscureText1,
              decoration: InputDecoration(
                labelStyle: const TextStyle(fontSize: 15),
                hintStyle: const TextStyle(fontSize: 15),
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                suffixIcon: IconButton(
                  icon: Icon(
                    color: Colors.grey,
                    _obscureText1 ? Iconsax.eye_slash : Iconsax.eye,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
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
                onPressed: _registerUser,
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
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
                  "Already have an account!",
                  style: TextStyle(fontSize: 15, color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user with email and password
        final userCredential = await widget.auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Get the user ID
        final userId = userCredential.user!.uid;

        // Store user details in Firestore
        await widget.firestore
            .collection('users')
            .doc(userId) // Use user ID as document ID
            .set({
          'userId': userId,
          'email': _emailController.text,
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phoneNumber': _phoneNumberController.text,
          'username': _usernameController.text,
          'gender': _genderController.text,
          'dob': _dobController.text,
        });

        // Show a snackbar for registration success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User registered successfully'),
          ),
        );

        // Navigate to home screen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ),
        );
      } catch (e) {
        // Show a snackbar for registration error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }


// void _registerUser() async {
//   if (_formKey.currentState!.validate()) {
//     try {
//       await widget.auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       await widget.firestore
//           .collection('users')
//           .doc(_emailController.text)
//           .set({
//         'email': _emailController.text,
//         'firstName': _firstNameController.text,
//         'lastName': _lastNameController.text,
//         'phoneNumber': _phoneNumberController.text,
//         'username': _usernameController.text,
//         'gender': _genderController.text,
//         'dob': _dobController.text,
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('User registered successfully'),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }
// }
}
