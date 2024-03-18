import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("24X7 Customer Support", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              // color: Colors.white,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Get quick customer support by selecting your item", style: TextStyle(fontSize: 18),textAlign: TextAlign.left,maxLines: 2,overflow: TextOverflow.ellipsis,),
                          const Gap(16),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(5)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              child: Text("Login to select an item", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                            ),
                          )
                        ],
                      ),
                    ),

                    Image.network("https://www.alamancecc.edu/_resources/images/icons/icon-06.png", height: 140, width: 140,)
                  ],
                ),
              ),
            ),
            const Gap(20),
            Material(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("What issue are you facing?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("I want to manage my order", style: TextStyle(fontSize: 14),),
                            Gap(5),
                            Text("View,cancel or return an order", style: TextStyle(fontSize: 14, color: Colors.grey),),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                      ],
                    ),
                    const Gap(10),
                    const Divider(thickness: 0.5,),
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("I want help with returns & refunds", style: TextStyle(fontSize: 14),),
                            Text("Manage and track returns", style: TextStyle(fontSize: 14, color: Colors.grey),),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                      ],
                    ),
                    const Gap(10),
                    const Divider(thickness: 0.5,),
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("I want help with other issues", style: TextStyle(fontSize: 14,),),
                            Text("Offers,payment & all other issues", style: TextStyle(fontSize: 14, color: Colors.grey),),
                          ],
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                      ],
                    ),
                    const Gap(10),
                    const Divider(thickness: 0.5,),
                    const Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("I want to contact the seller", style: TextStyle(fontSize: 14),),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Gap(20),
            Material(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Browse Help Topics", style: TextStyle(fontSize: 14),),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_outlined))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
