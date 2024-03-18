import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/screens/signin_screen.dart';

import '../../../models/user_model.dart';
import '../components/profile_pic.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  void showAlertDialog(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    Widget cancelButton = TextButton(
      child: const Text("Cancel", style: TextStyle(),),
      onPressed: () {
        Navigator.of(context).pop(); // Close the dialog
      },
    );

    Widget continueButton = TextButton(
      child: const Text("Continue", style: TextStyle(),),
      onPressed: () async {
        try {
          // Delete user document from Firestore
          await FirebaseFirestore.instance.collection('users').doc(user!.uid).delete();

          // Delete user from authentication
          await user.delete();

          // Navigate to the login screen
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const SignInScreen()),
                (Route<dynamic> route) => false,
          );
        } catch (error) {
          print("Error deleting user: $error");
          // Handle errors or display error message to the user
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Account", style: TextStyle(),),
      content: const Text("Are you sure you want to delete your account permanently?", style: TextStyle(),),
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
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final UserModel userData = UserModel.fromSnapshot(snapshot.data!);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold),
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
                      Center(child: ProfilePic(userId: user.uid)),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  const Text('Profile Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3,child: Text('Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text('${userData.firstName} ${userData.lastName}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3, child: Text('UserName', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.userName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  const SizedBox(height: 10,),
                  const Divider(),
                  const SizedBox(height: 10,),
                  const Text('Personal Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3, child: Text('User Id', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.id, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis,)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.copy))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3, child: Text('E-Mail', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.email, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3, child: Text('Phone Number', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.phoneNumber, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3, child: Text('Gender', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.gender, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(flex: 3, child: Text('Date Of Birth', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      Expanded(flex: 5, child: Text(userData.dob, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),)),
                      IconButton(onPressed: (){}, icon: const Icon(Iconsax.arrow_right_3))
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 15,),
                  Center(child: TextButton(onPressed: (){showAlertDialog(context);}, child: const Text('Close Account', style: TextStyle(fontSize: 14, color: Colors.red),)))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}