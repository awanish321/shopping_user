import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Iconsax.arrow_left), onPressed: () {},),
        title: Text('Orders', style: GoogleFonts.nunitoSans(textStyle: const TextStyle(fontWeight: FontWeight.bold)),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                      height: 85,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(15)

                      ),
                      child: Center(child: Image.asset('assets/images/nike-shoes.png', fit: BoxFit.contain, height: 65, width: 65,)),
                  ),
                  Column(
                    children: [
                      const Text('Nike Sports Shoe'),
                      Row(
                        children: [
                          const Text('4'),
                          RatingBar.builder(
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            itemCount: 1,
                            itemSize: 16,
                            itemPadding: const EdgeInsets.symmetric(
                                horizontal: 4),
                            itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.red),
                            onRatingUpdate: (index) {},
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
