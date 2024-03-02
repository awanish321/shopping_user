import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/home/home_screen.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 170),
        child: Column(
          children: [
            Lottie.asset('assets/cart.json',),
            const Gap(20),
            Text("Your Cart is Empty", style: GoogleFonts.nunitoSans(fontSize: 30, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const Gap(10),
            Text("Look's like you haven't \n added items in your cart yet.", style: GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
            const Gap(50),
            SizedBox(
              height: 50,
              width: 260,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }, child: Text("Add Item", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
            )

          ],
        ),
      ),
    );
  }
}
