import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/screens/signin_screen.dart';

import '../../../models/user_model.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key,});

  void showAlertDialog(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    Widget cancelButton = TextButton(
      child: Text("Cancel", style: GoogleFonts.nunitoSans(),),
      onPressed: () {
        Navigator.of(context).pop(); // Close the dialog
      },
    );

    Widget continueButton = TextButton(
      child: Text("Continue", style: GoogleFonts.nunitoSans(),),
      onPressed: () async {
        try {
          // Delete user document from Firestore
          await FirebaseFirestore.instance.collection('users').doc(user!.uid).delete();

          // Delete user from authentication
          await user.delete();

          // Navigate to the login screen
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SigninScreen()),
                (Route<dynamic> route) => false,
          );
        } catch (error) {
          print("Error deleting user: $error");
          // Handle errors or display error message to the user
        }
      },
    );


    AlertDialog alert = AlertDialog(
      title: Text("Delete Account", style: GoogleFonts.nunitoSans(),),
      content: Text("Are you sure you want to delete your account permanently?", style: GoogleFonts.nunitoSans(),),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final UserModel userData = UserModel.fromSnapshot(snapshot.data!);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Profile',
              style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          child: Image.asset('assets/images/Profile Image.png'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Change Profile Picture',
                          style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Text('Profile Information', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3,child: Text('Name', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.firstName} ${userData.lastName}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('UserName', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.userName, style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  Text('Personal Information', style: GoogleFonts.nunitoSans(fontSize: 20, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('User Id', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.id}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.copy))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('E-Mail', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.email}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('Phone Number', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.phoneNumber}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('Gender', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.gender}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(flex: 3, child: Text('Date Of Birth', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.dob}', style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 15,),
                  Center(child: TextButton(onPressed: (){showAlertDialog(context);}, child: Text('Close Account', style: GoogleFonts.nunitoSans(fontSize: 15, color: Colors.red),)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}