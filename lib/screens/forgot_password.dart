// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:shopping_app/screens/signup_screen.dart';
//
// class ForgotPassword extends StatefulWidget {
//   const ForgotPassword({super.key});
//
//   @override
//   State<ForgotPassword> createState() => _ForgotPasswordState();
// }
//
// class _ForgotPasswordState extends State<ForgotPassword> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Forgot Password', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold)),),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Text(
//                 "Change Password",
//                 style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30))
//               ),
//               Text(
//                 "Please enter your email and we will send \nyou a link to return to your account",
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey))
//               ),
//               const SizedBox(
//                 height: 50,
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(
//                   labelText: 'E-mail',
//                   labelStyle: GoogleFonts.nunitoSans(),
//                   hintText: 'Enter your email',
//                   hintStyle: GoogleFonts.nunitoSans(),
//                   suffixIcon: const Icon(Iconsax.sms),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter your email';
//                   }
//                   // You can add more email validation here
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 50),
//               SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.deepOrangeAccent),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                   ),
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Processing Data')),
//                       );
//                     }
//                   },
//                   child: Text(
//                     'CONTINUE',
//                     style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 50),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Don't have an account?",
//                     style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, color: Colors.grey))
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SignupScreen()));
//                     },
//                     child: Text(
//                       'Sign Up',
//                       style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/screens/signup_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // Future<void> _resetPassword() async {
  //   try {
  //     await FirebaseAuth.instance.sendPasswordResetEmail(
  //       email: _emailController.text,
  //     );
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Password reset email sent'),
  //       ),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       debugPrint('No user found for that email.');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('No user found for that email.'),
  //         ),
  //       );
  //     } else {
  //       debugPrint('Error sending password reset email: ${e.message}');
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Error sending password reset email: ${e.message}'),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint('Error sending password reset email: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Error sending password reset email: $e'),
  //       ),
  //     );
  //   }
  // }


  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent'),
        ),
      );
      // Navigate back to sign-in screen
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
          ),
        );
      } else {
        debugPrint('Error sending password reset email: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sending password reset email: ${e.message}'),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error sending password reset email: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error sending password reset email: $e'),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: GoogleFonts.nunitoSans(
            textStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Change Password",
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: GoogleFonts.nunitoSans(),
                    hintText: 'Enter your email',
                    hintStyle: GoogleFonts.nunitoSans(),
                    suffixIcon: const Icon(Iconsax.sms),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
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
              ),
              const SizedBox(height: 50),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepOrangeAccent,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _resetPassword(); // Call the _resetPassword function
                    }
                  },
                  child: Text(
                    'CONTINUE',
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.nunitoSans(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen(),
                        ),
                      );
                    },
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}