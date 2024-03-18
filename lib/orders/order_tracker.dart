import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class TrackOrders extends StatefulWidget {
  const TrackOrders({super.key});

  @override
  State<TrackOrders> createState() => _TrackOrdersState();
}

class _TrackOrdersState extends State<TrackOrders> with TickerProviderStateMixin {

  // List<step.Step> steps = []



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          content(),
          body()
        ],
      ),
    );
  }

  Widget content(){
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50)
          )
      ),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Lottie.asset("assets/track_orders.json", height: 200),
            const Text("Track Order", style: TextStyle(fontSize: 30),)
          ],
        ),
      ),
    );
  }

  Widget body(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Gap(50),
        const Text("Tracking Number : ", style: TextStyle(fontSize: 18),),
        const Gap(10),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 310,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,),
                    hintText: "e.g #1234567890"),
                ),
              ),
              const Gap(30),
                const Icon(Icons.search, size: 30,),
            ],
          ),
        )
      ],
    );
  }

}
