// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shopping_app/home/components/search_field.dart';
// import 'package:shopping_app/models/user_model.dart';
// import 'package:shopping_app/screens/profile/components/notifications_screen.dart';
// import '../cart/cart.dart';
// import 'components/categories.dart';
// import 'components/icon_btn_with_counter.dart';
// import 'components/popular_product.dart';
// import 'components/special_offers.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   UserModel? _user; // Variable to hold the user data
//
//   @override
//   void initState() {
//     super.initState();
//     _getUserData(); // Fetch user data when the screen initializes
//   }
//
//   // Method to fetch user data from FireStore
//   void _getUserData() async {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     DocumentSnapshot<Map<String, dynamic>> userSnapshot =
//     await FirebaseFirestore.instance.collection('users').doc(userId).get();
//     setState(() {
//       _user = UserModel.fromSnapshot(userSnapshot); // Update the user data
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: const Color(0xFFF5F5F3),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Good day for shopping',
//                         style: GoogleFonts.nunitoSans(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           color: Colors.black,
//                         ),
//                       ),
//                       Text(
//                         _user != null ? '${_user!.firstName} ${_user!.lastName}' : 'Loading...',
//                         style: GoogleFonts.nunitoSans(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                       )
//
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       IconBtnWithCounter(
//                         svgSrc: "assets/icons/Cart Icon.svg",
//                         press: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const CartScreen(),
//                             ),
//                           );
//                         },
//                       ),
//                       const SizedBox(width: 8),
//                       IconBtnWithCounter(
//                         svgSrc: "assets/icons/Bell.svg",
//                         numOfitem: 0,
//                         press: () {
//                           Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
//                         },
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             const Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 20, right: 20),
//                     child: SearchField(),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 20),
//                 //   // child: Container(
//                 //   //   height: 55,
//                 //   //   width: 60,
//                 //   //   decoration: BoxDecoration(
//                 //   //     color: const Color(0xFF979797).withOpacity(0.2),
//                 //   //     shape: BoxShape.rectangle,
//                 //   //     borderRadius: const BorderRadius.all(Radius.circular(20)),
//                 //   //   ),
//                 //   //   // child: IconButton(
//                 //   //   //   onPressed: () {},
//                 //   //   //   icon: const FaIcon(FontAwesomeIcons.sliders, size: 20),
//                 //   //   // ),
//                 //   // ),
//                 // )
//               ],
//             ),
//             const SizedBox(height: 20),
//             const SpecialOffers(),
//             const SizedBox(height: 20),
//             const Categories(),
//             const SizedBox(height: 15),
//             const PopularProducts(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//       // bottomNavigationBar: MyBottomNavBar(),
//     );
//   }
// }
//
//



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/home/components/search_field.dart';
import 'package:shopping_app/models/user_model.dart';
import '../cart/cart.dart';
import '../screens/profile/components/notifications/empty_notifications_screen.dart';
import 'components/categories.dart';
import 'components/icon_btn_with_counter.dart';
import 'components/popular_product.dart';
import 'components/special_offers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // Method to fetch user data from FireStore
  void _getUserData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
      setState(() {
        _user = UserModel.fromSnapshot(userSnapshot);
        _isLoading = false;
      });
    } catch (error) {
      print("Error fetching user data: $error");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFF5F5F3),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good day for shopping',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _user != null ? '${_user!.firstName} ${_user!.lastName}' : 'Loading...',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Cart Icon.svg",
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      IconBtnWithCounter(
                        svgSrc: "assets/icons/Bell.svg",
                        numOfitem: 0,
                        press: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const NotificationScreen()));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: SearchField(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Categories(),
            const SizedBox(height: 20),
            const SpecialOffers(),
            const SizedBox(height: 15),
            const PopularProducts(),
            const SizedBox(height: 20),
          ],
        ),
      ),
      // bottomNavigationBar: MyBottomNavBar(),
    );
  }
}