import 'package:flutter/material.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return
        // Address bar
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12, top: 0, bottom: 0),
          child: Container(
            padding: const EdgeInsets.symmetric( horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              children: [
            // Location icon
                const Icon(
                 Icons.location_on,
                  color: Colors.black,
                  size: 25,
                ),
              const SizedBox(width: 10),

              const Text(
                "Deliver to",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                 ),
                ),
              const SizedBox(width: 5),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   const Text(
                      "Awanish - Dholka 382225",
                        maxLines: 1,
                        style: TextStyle(
                       color: Colors.black,
                      fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down_outlined, size: 30,),
                        color: Colors.black,
                        onPressed:(){}
                    ),
                ],
              ),
          ],
                ),
              ),
        );
  }
}
