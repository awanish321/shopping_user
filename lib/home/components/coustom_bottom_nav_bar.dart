import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shopping_app/orders/orders.dart';
import 'package:shopping_app/orders/orders_screen.dart';
import 'package:shopping_app/wishlist/wishlist.dart';
import 'package:shopping_app/home/home_screen.dart';
import 'package:shopping_app/screens/profile/profile_screen.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int myCurrentIndex = 0;
  late List<Widget> pages; // Declare the type explicitly

  // Initialize the pages variable in the constructor
  _MyBottomNavBarState() {
    pages = [
      const HomeScreen(),
      OrdersScreen(),
      const WishlistScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF8A80),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.redAccent,
            unselectedItemColor: Colors.black,
            selectedLabelStyle: GoogleFonts.nunitoSans(),
            unselectedLabelStyle: GoogleFonts.nunitoSans(),
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            selectedFontSize: 13,
            unselectedFontSize: 13,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.shopping_bag),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.heart),
                label: "Wishlist",
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
