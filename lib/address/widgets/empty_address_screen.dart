import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class EmptyAddressScreen extends StatelessWidget {
  const EmptyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
        child: Column(
          children: [
            Lottie.asset('assets/empty_address.json'),
            const Gap(20),
            const Text("We are waiting for your address!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const Gap(10),
            const Text("You have not added address yet.", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
