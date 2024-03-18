import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/home/home_screen.dart';

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/e_order.json',),
              const Text("No order placed yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const Gap(10),
              const Text("You have not placed an order yet. \nPlease add items to your cart and checkout when you are ready.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
              const Gap(35),
              SizedBox(
                height: 50,
                width: 260,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }, child: const Text("Explore Item's", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
