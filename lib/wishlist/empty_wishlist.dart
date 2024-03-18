import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
            const Text("Your Wishlist is Empty!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const Gap(10),
            const Text("Explore more and \n shortlist some items and add them to your wishlist.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
            const Gap(45),
            SizedBox(
              height: 50,
              width: 260,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }, child: const Text("Add Items", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
