import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/home/home_screen.dart';

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders", style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/order.json',),
              Text("No order placed yet", style: GoogleFonts.nunitoSans(fontSize: 35, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const Gap(10),
              Text("You have not placed an order yet. \nPlease add items to your cart and checkout when you are ready.", style: GoogleFonts.nunitoSans(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
              const Gap(35),
              SizedBox(
                height: 50,
                width: 260,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }, child: Text("Explore Item's", style: GoogleFonts.nunitoSans(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
