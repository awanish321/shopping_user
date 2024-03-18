import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/home/home_screen.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/em_car.json',),
            const Gap(20),
            const Text("Your Cart is Empty", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const Gap(10),
            const Text("Look's like you haven't \n added items in your cart yet.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
            const Gap(50),
            SizedBox(
              height: 50,
              width: 260,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                  }, child: const Text("Add Item", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
            )
          ],
        ),
      ),
    );
  }
}
