// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shopping_app/address/address.dart';
// import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
// import 'package:shopping_app/screens/profile/components/help_center.dart';
// import 'package:shopping_app/screens/profile/components/setting_screen.dart';
// import 'package:shopping_app/screens/profile/widgets/profile.dart';
// import 'components/profile_menu.dart';
// import 'components/profile_pic.dart';
//
// class ProfileScreen extends StatelessWidget {
//
//   final String userId;
//   const ProfileScreen({super.key, required this.userId});
//   @override
//   Widget build(BuildContext context) {
//
//     Future<void> signOut() async {
//       await FirebaseAuth.instance.signOut();
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomNavBar()));
//         },),
//         title: Text("Profile",style: TextStyle(fontWeight: FontWeight.bold), ),
//       ),
//       body: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const ProfilePic(userId:,),
//           const SizedBox(height: 20),
//           ProfileMenu(
//             text: "My Account",
//             icon: "assets/icons/User Icon.svg",
//             press: (){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfile()));
//             },
//           ),
//           ProfileMenu(
//             text: "Addresses",
//             icon: "assets/location-point-svgrepo2-com.svg",
//             press: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const UserAddressScreen()));
//             },
//           ),
//           ProfileMenu(
//             text: "Settings",
//             icon: "assets/icons/Settings.svg",
//             press: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
//             },
//           ),
//           ProfileMenu(
//             text: "Help Center",
//             icon: "assets/icons/Question mark.svg",
//             press: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterScreen()));
//             },
//           ),
//           ProfileMenu(
//             text: "Log Out",
//             icon: "assets/icons/Log out.svg",
//             press: () => signOut(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//


import 'package:flutter/material.dart';
import 'package:shopping_app/address/address.dart';
import 'package:shopping_app/home/components/coustom_bottom_nav_bar.dart';
import 'package:shopping_app/screens/profile/components/help_center.dart';
import 'package:shopping_app/screens/profile/components/notifications/message_screen.dart';
import 'package:shopping_app/screens/profile/components/privacy_policy.dart';
import 'package:shopping_app/screens/profile/components/profile_menu.dart';
import 'package:shopping_app/screens/profile/components/profile_pic.dart';
import 'package:shopping_app/screens/profile/widgets/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/screens/signin_screen.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({Key? key,}) : super(key: key);

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BottomNavBar()),
            );
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ProfilePic(userId: ''),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icons/User Icon.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserProfile()),
                );
              },
            ),
            ProfileMenu(
              text: "Addresses",
              icon: "assets/address.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserAddressScreen()),
                );
              },
            ),
            // ProfileMenu(
            //   text: "Settings",
            //   icon: "assets/icons/Settings.svg",
            //   press: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const SettingsScreen()),
            //     );
            //   },
            // ),
            ProfileMenu(
              text: "Notification",
              icon: "assets/icons/Bell.svg",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications(id: '',)));
              },
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpCenterScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "Privacy Policy",
              icon: 'assets/insurance.svg',
              // icon: "assets/icons/Question mark.svg",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
                );
              },
            ),
            ProfileMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () => signOut(context),
            ),
          ],
        ),
      ),
    );
  }
}
