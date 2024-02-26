import 'package:flutter/material.dart';

class SpecialforYou extends StatefulWidget {
  const SpecialforYou({super.key});

  @override
  State<SpecialforYou> createState() => _SpecialforYouState();
}

class _SpecialforYouState extends State<SpecialforYou> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Text("Special for you")
            ],
          )
        ],
      ),
    );
  }
}
