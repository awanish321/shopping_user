import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:shopping_app/home/home_screen.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.deepOrangeAccent,
        title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/notification.json', height: 200, width: 200),
              const Text("No Message Notifications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              const Gap(10),
              const Text("Once you get any \n notification please check here.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
              const Gap(45),
              SizedBox(
                height: 50,
                width: 260,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrangeAccent),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    }, child: const Text("Go to Home", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
