import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../home/home_screen.dart';

class EmptyWishlistScreen extends StatelessWidget {
  const EmptyWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
        child: Column(
          children: [
            Lottie.asset('assets/images/favourites.json',height: 250),
            const Gap(20),
            Text("Your Wishlist is Empty!", style: GoogleFonts.nunitoSans(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const Gap(10),
            Text("Explore more and \n shortlist some items and add them to your wishlist.", style: GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
            const Gap(45),
            SizedBox(
              height: 50,
              width: 260,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }, child: Text("Add Items", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
