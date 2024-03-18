import 'package:flutter/material.dart';
import 'package:shopping_app/address/widgets/empty_address_screen.dart';
import 'package:shopping_app/address/widgets/single_address.dart';
import 'package:shopping_app/address/add_new_address.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';


class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrangeAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewAddressScreen(),
            ),
          );
        },
        child: const Icon(
          Iconsax.add,
          color: Color(0xFFFFFFFF),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Addresses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Addresses')
            .doc(user!.email) // Get addresses specific to the user's email
            .collection('addresses')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final addresses = snapshot.data!.docs;
            if (addresses.isEmpty) {
              return const EmptyAddressScreen();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: addresses.map<Widget>((address) {
                    final data = address.data() as Map<String, dynamic>;
                    return TSingleAddress(
                      addressData: data,
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}



